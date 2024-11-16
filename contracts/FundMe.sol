// Get funds from users 
// Withdraw funds 
// Set a minimum finding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

contract FundMe{
    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18; // 1 * 10 ** 18

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function fund() public payable {
        // Want to be able to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract?
        // msg.value.getConversionRate();
        // a ton of computation here
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough!"); // 1e18 = 1000000000000000000
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public {
        // for each owner -> require(msg.sender == owner, "Sender isn't owner!");
        // for loop // start index, ending index, step amount
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0); // reset the array
        // actually withdraw the funds
        // transfer // msg.sender = adress // payable(msg.sender) = payable address
        // payable(msg.sender).transfer(address(this).balance);
        // // send 
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        //call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    // modifier -> many owners
    modifier onlyOwner{
        require(msg.sender == owner, "Sender isn't owner!");
        _; // do other codes in withdraw() afterwards
    }
}