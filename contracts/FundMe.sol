// Allow users to send funds
// Withdraw funds 
// Set minimum fund amount in USD 

// SPDX-License-Identifier: MIT

pragma solidity 0.8.36;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18;

    address[]public funders;
    mapping(address funders => uint256 amountFunded) public addressToAmountFunded;
    
    address public immutable i_owner;
    constructor() {
     i_owner = msg.sender; 
    }

    modifier onlyowner() {
        require(msg.sender == i_owner, "Not the owner");
        _;
    }
    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enough eth"); // Requires the user to not send less than 5usd worth of eth
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + (msg.value); 
    }  

    function withdraw() public onlyowner {
        require(msg.sender == i_owner, "Must be the owner");
       for (uint256 funderIndex=0; funderIndex<funders.length; funderIndex++){
        address funder = funders[funderIndex];
        addressToAmountFunded[funder] = 0;
       }

       funders = new address [](0);

       // call to send eth
       (bool callsuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
       require(callsuccess, "Call failed");
    }  

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
 
