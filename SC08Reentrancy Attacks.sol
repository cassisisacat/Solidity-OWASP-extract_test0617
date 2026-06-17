// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IToken {
    function transfer(address to, uint256 amount) external returns (bool);
}

contract VulnerableVault {
    IToken public immutable token;
    mapping(address => uint256) public balances;

    constructor(IToken _token) {
        token = _token;
    }

    function deposit(uint256 amount) external {
        // Assume token already transferred in for brevity
        balances[msg.sender] += amount;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "insufficient");

        // External call before state update – reentrancy window
        token.transfer(msg.sender, amount);

        balances[msg.sender] -= amount;
    }
}