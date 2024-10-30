// Get funds from users 
// Withdraw funds 
// Set a minimum finding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe{

    uint256 public minimumUsd = 50;

    function fund() public payable {
        // Want to be able to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract?
        require(msg.value >= minimumUsd, "Didn't send enough!"); // 1e18 = 1000000000000000000
    }

    function getPrice() public view returns(uint256){
        //ABI 
        //Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 price,,, ) = priceFeed.latestRoundData();
        //ETH in trms of USD
        //3000.000000
        return uint256(price * 1e10);
    }

    function getVersion() public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    function getConversionRate() public {}

    // function withdraw(){}
}