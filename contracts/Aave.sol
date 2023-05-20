// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAaveV2 {
    function depositETH(address lendingPool, address onBehalfOf, uint16 referralCode) external payable;

    function withdrawETH(address lendingPool, uint256 amount, address to) external;
}

interface ILendingPoolAddressesProvider {
    function getLendingPool() external view returns (address);
}

interface IAToken {
    function balanceOf(address user) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function allowance(address _owner, address _spender) external view returns (uint256 remaining);
}

contract Aave {
    IAToken public iAToken;
    IAaveV2 private iAaveV2;

    address aToken = 0x22404B0e2a7067068AcdaDd8f9D586F834cCe2c5;
    address lendingPool = 0x5E52dEc931FFb32f609681B8438A51c675cc232d;
    address aaveV2Contract = 0x3bd3a20Ac9Ff1dda1D99C0dFCE6D65C4960B3627;

    constructor() {
        iAToken = IAToken(aToken);
        iAaveV2 = IAaveV2(aaveV2Contract);
    }

    function getBalance(address user) external view returns (uint256) {
        return iAToken.balanceOf(user);
    }

    function getLendingPoolAddress() public view returns (address) {
        ILendingPoolAddressesProvider lendingPoolAddressesProvider = ILendingPoolAddressesProvider(lendingPool);
        return lendingPoolAddressesProvider.getLendingPool();
    }

    function stakeEth() external payable {
        address LENDING_POOL_ADDRESS = getLendingPoolAddress();

        iAaveV2.depositETH{ value: msg.value }(LENDING_POOL_ADDRESS, address(this), 0);

        require(true, "Deposit to Aave failed");
    }

    // function approveToken(uint256 _amount) external {
    //     bool success = iAToken.approve(aaveV2Contract, _amount);

    //     require(success, "Approve failed");
    // }

    function allowance() public view returns (uint256 remaining) {
        return iAToken.allowance(address(this), aaveV2Contract);
    }

    function withdrawEth(uint256 _amount) external {
        address LENDING_POOL_ADDRESS = getLendingPoolAddress();

        bool success = iAToken.approve(aaveV2Contract, _amount);

        require(success, "Approve failed");

        iAaveV2.withdrawETH(LENDING_POOL_ADDRESS, _amount, address(this));
    }

    receive() external payable {}
}
