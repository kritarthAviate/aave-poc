// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAToken {
    function balanceOf(address user) external view returns (uint256);

    function transfer(address to, uint256 amount) external returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);

    function allowance(address _owner, address _spender) external view returns (uint256 remaining);

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
}
