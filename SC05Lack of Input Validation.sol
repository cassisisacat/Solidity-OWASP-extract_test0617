// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableConfig {
    uint256 public feeBps;      // basis points 0–10_000
    uint256 public maxDeposit;  // upper bound for deposits

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function setConfig(uint256 _feeBps, uint256 _maxDeposit) external {
        // Missing: access control and bounds checks
        feeBps = _feeBps;
        maxDeposit = _maxDeposit;
    }
}