// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IERC6551Registry {

    function proxyCallAccount(
        bytes32 salt, 
        address[] memory targets, 
        uint256[] memory values, 
        bytes[] memory calldatas
    ) external returns(bytes[] memory outputs);

    function account(
        bytes32 salt, 
        address caller
    ) external view returns (address);
}
