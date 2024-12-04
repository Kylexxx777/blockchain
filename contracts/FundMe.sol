// Get funds from users 
// Withdraw funds 
// Set a minimum finding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

// create costum error
error NotOwner();

// constant, immmutable
//859,757 //683,935
contract FundMe{
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18; // 1 * 10 ** 18
    // 347 - constant // 2446 - w/o constant
    // 347 * 14100000000 = 4,892,700,000,000 = 0.0000048927 ETH
    // 2446 * 14100000000 = 34,488,600,000,000 = 0.0000344886 ETH
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;
        // 439 gas - immutable // 2574 gas - not immutable

    }

    function fund() public payable {
        // Want to be able to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract?
        // msg.value.getConversionRate();
        // a ton of computation here
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough!"); // 1e18 = 1000000000000000000
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
        // require(msg.sender == i_owner, "Sender isn't owner!");
        if(msg.sender != i_owner) { revert NotOwner(); }
        _; // do other codes in withdraw() afterwards
    }

    // What happens if someone sends this contract ETH w/o calling the fund function
    // recieve
    receive() external payable { 
        fund();
    }

    //fallback
    fallback() external payable { 
        fund();
    }

}


// More to learn
//1. Enums
//2. Events
//3. Try/Catch
//4. Function Selector
//5. abi.encode/decode
//6. Hashing
//7. Yul/Assembly