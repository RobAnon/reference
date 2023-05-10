// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/Clones.sol";

import "./interfaces/IERC6551Registry.sol";
import "./interfaces/IERC6551Account.sol";
import "./ERC6551Account.sol";

contract ERC6551Registry is IERC6551Registry {

    /// Address to use for EIP-1167 smart-wallet creation calls
    address public immutable TEMPLATE;

    constructor() {
        TEMPLATE = address(new ERC6551Account());
    }

    function proxyCallAccount(
        bytes32 salt, 
        address[] memory targets, 
        uint256[] memory values, 
        bytes[] memory calldatas
    ) external returns(bytes[] memory outputs) {
        IERC6551Account wallet = IERC6551Account(Clones.cloneDeterministic(TEMPLATE, keccak256(abi.encode(salt, msg.sender))));
        //Proxy the calls through and selfDestruct itself when finished
        outputs = wallet.executeCall(targets, values, calldatas);
        wallet.cleanMemory();
    }

    function account(
        bytes32 salt, 
        address caller
    ) external view returns (address smartWallet) {
        smartWallet = Clones.predictDeterministicAddress(TEMPLATE, keccak256(abi.encode(salt, caller)));
    }
}
