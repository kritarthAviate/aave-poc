// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IAaveV2.sol";
import "./interfaces/IAToken.sol";
import "./interfaces/ILendingPoolAddressesProvider.sol";
import "hardhat/console.sol";

/// @title Aave Contract
/// @notice This contract allows users to interact with the Aave V2 protocol for lending and borrowing assets.
contract Aave {
    IAToken public iAToken;
    IAaveV2 private iAaveV2;
    ILendingPoolAddressesProvider private iLendingPoolAddressesProvider;

    address aaveV2Contract;

    /// @notice Emitted when ETH is staked in the Aave protocol.
    /// @param user The address of the user who staked ETH.
    /// @param amount The amount of ETH staked.
    /// @param timestamp The timestamp when the staking occurred.
    event StakeEth(address indexed user, uint256 amount, uint256 timestamp);

    /// @notice Emitted when ETH is withdrawn from the Aave protocol.
    /// @param user The address of the user who withdrew ETH.
    /// @param amount The amount of ETH withdrawn.
    /// @param timestamp The timestamp when the withdrawal occurred.
    event WithdrawEth(address indexed user, uint256 amount, uint256 timestamp);

    /// @notice Constructs the Aave contract.
    /// @param _aToken The address of the aToken contract for the underlying asset.
    /// @param _lendingPoolProvider The address of the LendingPoolAddressesProvider contract.
    /// @param _aaveV2Contract The address of the AaveV2 contract.
    constructor(address _aToken, address _lendingPoolProvider, address _aaveV2Contract) {
        iAToken = IAToken(_aToken);
        iAaveV2 = IAaveV2(_aaveV2Contract);
        iLendingPoolAddressesProvider = ILendingPoolAddressesProvider(_lendingPoolProvider);
        aaveV2Contract = _aaveV2Contract;
    }

    /// @notice Retrieves the balance of the specified user.
    /// @param user The address of the user.
    /// @return The balance of the user in the aToken.
    function getBalance(address user) external view returns (uint256) {
        return iAToken.balanceOf(user);
    }

    /// @notice Retrieves the address of the LendingPool contract.
    /// @return The address of the LendingPool contract.
    function getLendingPoolAddress() public view returns (address) {
        return iLendingPoolAddressesProvider.getLendingPool();
    }

    /// @notice Stakes ETH in the Aave protocol.
    function stakeEth() external payable {
        address LENDING_POOL_ADDRESS = getLendingPoolAddress();

        iAaveV2.depositETH{ value: msg.value }(LENDING_POOL_ADDRESS, address(this), 0);

        iAToken.transfer(msg.sender, msg.value);

        require(true, "Deposit to Aave failed");

        emit StakeEth(msg.sender, msg.value, block.timestamp);
    }

    /// @notice Retrieves the allowance granted by this contract to the AaveV2 contract.
    /// @return tokenAllowance The remaining allowance.
    function allowance() public view returns (uint256) {
        return iAToken.allowance(address(this), aaveV2Contract);
    }

    /// @notice Withdraws ETH from the Aave protocol.
    /// @param _amount The amount of ETH to withdraw.
    function withdrawEth(uint256 _amount) external {
        address LENDING_POOL_ADDRESS = getLendingPoolAddress();
        console.log("LENDING_POOL_ADDRESS: %s", LENDING_POOL_ADDRESS);

        // Send the aTokens to this contract
        iAToken.transferFrom(msg.sender, address(this), _amount);

        // Approve the AaveV2 contract to spend the aTokens in this contract
        iAToken.approve(aaveV2Contract, _amount);

        // Withdraw the ETH from the AaveV2 contract
        iAaveV2.withdrawETH(LENDING_POOL_ADDRESS, _amount, msg.sender);

        emit WithdrawEth(msg.sender, _amount, block.timestamp);
    }

    /// @notice Fallback function to receive ETH
    receive() external payable {}
}
