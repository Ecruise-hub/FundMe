// Allow users to send funds
// Withdraw funds 
// Set minimum fund amount in USD 

// SPDX-License-Identifier: MIT

pragma solidity 0.8.36;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 5e18;

    address[]public funders;
    mapping(address funders => uint256 amountFunded) public addressToAmountFunded;
    
    address public owner;
    constructor() {
     owner = msg.sender; 
    }

    modifier onlyowner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
    function fund() public payable {
        require(msg.value.getConversionRate() >= minimumUsd, "didn't send enough eth"); // Requires the user to not send less than 5usd worth of eth
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + (msg.value); 
    }  

    function withdraw() public onlyowner {
        require(msg.sender == owner, "Must be the owner");
       for (uint256 funderIndex=0; funderIndex<funders.length; funderIndex++){
        address funder = funders[funderIndex];
        addressToAmountFunded[funder] = 0;
       }

       funders = new address [](0);

       // call to send eth
       (bool callsuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
       require(callsuccess, "Call failed");
    }  
}
 
