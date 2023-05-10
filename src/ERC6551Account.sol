// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import "./interfaces/IERC6551Account.sol";

contract ERC6551Account is IERC6551Account {

    address private immutable MASTER;

    constructor() {
        MASTER = msg.sender;
    }

    function executeCall(
        address[] memory targets, 
        uint256[] memory values, 
        bytes[] memory calldatas
    ) external payable returns(bytes[] memory outputs) {
        require(msg.sender == MASTER, "!owner");

        for (uint256 i = 0; i < targets.length; i++) {
            (bool success, bytes memory result) = targets[i].call{value: values[i]}(calldatas[i]);
            require(success, "Txn Failed!");
            outputs[i] = result;
        }
        // 95% certain there's a way to call clean_memory in here using calldata encoding
    }

    function cleanMemory() external {
        selfdestruct(payable(MASTER));
    }

}
