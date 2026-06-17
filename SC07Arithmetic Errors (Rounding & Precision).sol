// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableShares {
    uint256 public totalAssets;
    uint256 public totalShares;

    mapping(address => uint256) public balanceOf;

    function deposit(uint256 assets) external {
        require(assets > 0, "zero");

        uint256 shares;
        if (totalShares == 0) {
            shares = assets;
        } else {
            // Rounds down and may favor the depositor under certain edge states
            shares = (assets * totalShares) / totalAssets;
        }

        totalAssets += assets;
        totalShares += shares;
        balanceOf[msg.sender] += shares;
    }
}