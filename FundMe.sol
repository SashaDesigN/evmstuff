// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import './Price.sol';

/** 
 * @title Funding contract
 * @dev implements fundme functionality
 */
contract FundMe {

    using PriceConverter for uint256; 

    // ETH/USD data feed value
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    uint256 public min_fund = 50 * 1e18;
    address public owner;

    constructor () {
        owner = msg.sender;
    }

    function fund () public payable {
        require(msg.value.getConversionRate() >= min_fund, 'Not enough');
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw () public onlyOwner {        
        // make all funders amt to 0 again
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
          address funder = funders[funderIndex];  
          addressToAmountFunded[funder] = 0;
        }

        // reset funders array
        funders = new address[](0);
        (bool callSuccess, ) = payable (msg.sender).call{value: address(this).balance}('');
        require(callSuccess, 'Withdraw failed');
    }

    modifier onlyOwner {
        require(msg.sender == owner, 'Require to be owner'); 
        _;
    }

}
