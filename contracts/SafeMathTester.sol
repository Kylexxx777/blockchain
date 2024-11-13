// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeMathTester{
    uint8 public bigNumber = 255; 
    // ^0.6.0 unchecked  // ^0.8.0 checked
    function add() public {
        // bigNumber++; -> checked
        unchecked {bigNumber++;}
    }
}