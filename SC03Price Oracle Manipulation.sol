// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IPriceFeed {
    function latestAnswer() external view returns (int256);
}

contract VulnerableOracleLending {
    IPriceFeed public priceFeed; // single-point oracle
    mapping(address => uint256) public collateralEth;
    mapping(address => uint256) public debtUsd;

    constructor(IPriceFeed _feed) {
        priceFeed = _feed;
    }

    function depositCollateral() external payable {
        collateralEth[msg.sender] += msg.value;
    }

    function borrow(uint256 amountUsd) external {
        int256 price = priceFeed.latestAnswer(); // no sanity checks, no delay
        require(price > 0, "bad price");

        uint256 collateralUsd = (collateralEth[msg.sender] * uint256(price)) / 1e8;
        // Allows borrowing up to 100% of collateral value – overly generous
        require(collateralUsd >= amountUsd, "insufficient collateral");

        debtUsd[msg.sender] += amountUsd;
        // transfer stablecoin (omitted)
    }
}