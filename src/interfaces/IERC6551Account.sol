// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/// @dev the ERC-165 identifier for this interface is `0xeff4d378`
interface IERC6551Account {

    function executeCall(
        address[] memory targets, 
        uint256[] memory values, 
        bytes[] memory calldatas
    ) external payable returns (bytes[] memory);

    function cleanMemory() external;

}
