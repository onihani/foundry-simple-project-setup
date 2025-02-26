// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "forge-std/Script.sol";
import "../src/Spacebear.sol";

contract SpacebearScript is Script {
    function run() public {
        address deployer = 0xBf5D88BFDEE112DA8c980781cafB20cE8BFF81CB;

        // read private key as string from .secret
        string memory keyString = vm.readFile(".secret");

        // add "0x" prefix and parse as uint256
        string memory prefixedKey = string.concat("0x", keyString);
        uint256 privateKey = vm.parseUint(prefixedKey);

        // deploy contract
        vm.startBroadcast(privateKey);
        new Spacebear(deployer);
        vm.stopBroadcast();
    }
}
