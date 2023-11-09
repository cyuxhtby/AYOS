// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/AYOS.sol";

contract TestContract is Test {
    AYOS c;

    function setUp() public {
        c = new AYOS(
            address(this), // _defaultAdmin
            "AYOSTest", // _name
            "AYOSTest", // _symbol
            address(this), // _royaltyRecipient
            0, // _royaltyBps
            address(this) // _primarySaleRecipient
        );
        assertEq(c.name(), "AYOSTest", "Name is not set correctly");
        assertEq(c.symbol(), "AYOSTest", "Symbol is not set correctly"); 
        assertEq(c.primarySaleRecipient(), address(this), "Primary sale recipient is not set correctly");
    }

    function testBar() public {
        assertEq(uint256(1), uint256(1), "ok");
    }

    function testFoo(uint256 x) public {
        vm.assume(x < type(uint128).max);
        assertEq(x + x, x * 2);
    }
}
