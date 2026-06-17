// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IToken {
    function transfer(address to, uint256 amount) external returns (bool);
}

contract VulnerablePayout {
    IToken public token;

    mapping(address => uint256) public rewards;

    constructor(IToken _token) {
        token = _token;
    }

    function claim() external {
        uint256 amount = rewards[msg.sender];
        require(amount > 0, "no rewards");

        // Vulnerable: does not check return value or reentrancy
        token.transfer(msg.sender, amount);

        // State update after external call
        rewards[msg.sender] = 0;
    }
}