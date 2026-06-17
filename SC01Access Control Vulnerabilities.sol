// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract LiquidityPoolVulnerable {
    address public owner;
    mapping(address => uint256) public balances;

    constructor() {
        owner = msg.sender;
    }

    // Anyone can set a new owner – critical access control bug
    function transferOwnership(address newOwner) external {
        owner = newOwner; // No access control
    }

    // Intended to be called only by the owner to rescue tokens
    function emergencyWithdraw(address to, uint256 amount) external {
        // Missing: require(msg.sender == owner)
        require(balances[address(this)] >= amount, "insufficient");
        balances[address(this)] -= amount;
        balances[to] += amount;
    }
}