# FundMe

A decentralized crowdfunding smart contract built with Solidity. The contract allows users to fund the contract with ETH while enforcing a minimum USD contribution. It uses Chainlink price feeds to convert ETH to USD and provides owner-controlled withdrawals.

## Overview

FundMe is a Solidity-based crowdfunding smart contract that demonstrates how multiple smart contract concepts can work together in a practical application.

Users can send ETH to the contract as funding, while the contract uses a Chainlink ETH/USD price feed to determine whether the contribution meets the minimum required USD value.

Only the contract owner can withdraw the accumulated funds.

## Features

- Accepts ETH contributions from users
- Enforces a minimum contribution of $5 USD
- Converts ETH to USD using Chainlink price feeds
- Tracks contributors using an address array
- Records each contributor's funded amount using a mapping
- Uses a constructor to establish contract ownership
- Uses an `onlyOwner` modifier to restrict withdrawals
- Uses a reusable `PriceConverter` library
- Allows the contract owner to withdraw the accumulated ETH
- Resets contributor records after withdrawal

## Smart Contract Components

### PriceConverter Library

The `PriceConverter` library contains reusable functions for working with the Chainlink price feed.

It includes:

- `getPrice()` - Retrieves the current ETH/USD price from the Chainlink price feed.
- `getConversionRate()` - Converts a given amount of ETH into its USD value.
- `getVersion()` - Returns the version of the Chainlink price feed.

The library is used in `FundMe.sol` with:

solidity
using PriceConverter for uint256;

**Technologies Used**
Solidity
Ethereum
Chainlink Price Feeds
Remix IDE
Git & GitHub
Key Concepts Practiced

Through this project, I practiced and applied:

Solidity functions
Arrays
Mappings
Structs
Constructors
Modifiers
msg.sender
msg.value
payable
Data locations
Libraries
ETH transfers using call
Error handling with require
Integer overflow and underflow
Chainlink price feed integration
ETH/USD conversion
Access control
Deployment

The contract was deployed and tested on:

Network: Sepolia Testnet

Contract Address: 0xD2c309b808B3437d92635dcEe8e02d2A699EE655

Block Explorer: [YOUR BLOCK EXPLORER LINK]
