// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableLending {
    mapping(address => uint256) public collateral;
    mapping(address => uint256) public debt;
    uint256 public collateralFactorBps = 7500; // 75%

    function depositCollateral() external payable {
        collateral[msg.sender] += msg.value;
    }

    // Vulnerable: calculates borrow capacity using the *new* amount, not total
    function borrow(uint256 amount) external {
        uint256 allowed = (amount * collateralFactorBps) / 10_000;
        require(allowed >= amount, "not enough collateral"); // meaningless check

        debt[msg.sender] += amount;
        // send tokens from pool (omitted)
    }
}