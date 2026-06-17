// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableProxyAdmin {
    address public admin;
    address public implementation;

    constructor(address _implementation) {
        // Critical: no way to set custom admin; implicitly trusts deployer logic
        admin = msg.sender;
        implementation = _implementation;
    }

    function upgrade(address newImplementation) external {
        // Missing: access control (only admin) and sanity checks
        implementation = newImplementation;
    }
}