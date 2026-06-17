// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IFlashLender {
    function flashLoan(
        address receiver,
        uint256 amount,
        bytes calldata data
    ) external;
}

contract VulnerablePool {
    uint256 public totalShares;
    uint256 public totalAssets;

    mapping(address => uint256) public sharesOf;

    // Vulnerable: naive share minting with truncation benefit to sender
    function deposit(uint256 assets) external {
        uint256 shares;
        if (totalShares == 0) {
            shares = assets;
        } else {
            shares = (assets * totalShares) / totalAssets;
        }

        totalAssets += assets;
        totalShares += shares;
        sharesOf[msg.sender] += shares;
    }

    // No safeguard against flash-loan boosted deposit/withdraw loops
}