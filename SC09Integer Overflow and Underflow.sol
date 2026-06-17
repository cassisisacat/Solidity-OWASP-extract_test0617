// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;

contract VulnerableToken {
    mapping(address => uint256) public balances;

    function transfer(address to, uint256 amount) external {
        // UNDERFLOW: if balances[msg.sender] < amount, wraps to huge value
        balances[msg.sender] -= amount;  // Silent underflow!
        balances[to] += amount;          // Silent overflow possible
    }
}