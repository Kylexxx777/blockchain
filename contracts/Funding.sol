// Get funds from users 
// Withdraw funds 
// Set a minimum finding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract FundMe{

    uint256 public number;

    function fund() public payable {
        // Want to be able to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract?
        number = 5;
        require(msg.value >= 1e18, "Didn't send enough!"); // 1e18 = 1000000000000000000
    }

    // function withdraw(){}
}