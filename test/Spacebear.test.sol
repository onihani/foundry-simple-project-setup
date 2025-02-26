// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

import "forge-std/Test.sol";
import "../src/Spacebear.sol";

contract SpacebearTest is Test {
    Spacebear spacebear;

    function setUp() public {
        spacebear = new Spacebear(address(this));
    }

    function testNameIsSpacebear() public view {
        assertEq(spacebear.name(), "Spacebear");
    }

    function testSafeMint() public {
        spacebear.safeMint(msg.sender);
        assertEq(spacebear.ownerOf(0), msg.sender);
        assertEq(
            spacebear.tokenURI(0),
            "https://ethereum-blockchain-developer.com/2022-06-nft-truffle-hardhat-foundry/nftdata/spacebear_1.json"
        );
    }

    function testContractOwnership() public view {
        assertEq(spacebear.owner(), address(this));
    }

    function testMintByNonOwner() public {
        address minter = address(0x1);
        vm.startPrank(minter);
        vm.expectRevert();
        spacebear.safeMint(minter);
        vm.stopPrank();
    }

    function testPurchaseNft() public {
        address purchaser = address(0x2);
        vm.startPrank(purchaser);
        vm.deal(purchaser, 100 ether);
        spacebear.buyToken{value: 0.1 ether}();
        vm.stopPrank();
        assertEq(spacebear.ownerOf(0), purchaser);
    }
}
