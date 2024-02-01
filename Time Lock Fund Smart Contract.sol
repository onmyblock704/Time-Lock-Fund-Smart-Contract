// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LockFund {
    address public owner;
    mapping(address => uint) public lockedFunds;
    mapping(address => uint) public lockedTimestamps;
    mapping(address => uint) public lockedPeriod;
    mapping(address => bool) public isWithdrawn;
    uint public lockDuration1 = 1 days;
    uint public lockDuration2 = 2 days;
    uint public lockDuration3 = 3 days;
    uint public reward1 = 1 ether;
    uint public reward2 = 1.5 ether;
    uint public reward3 = 2 ether;

    constructor() {
        owner = payable(msg.sender); 
    }

    function lockFund(uint _value, uint _period) public payable {
        require(msg.value >= _value, "Amount should begreater than value");
        lockedFunds[msg.sender] = _value;
        lockedPeriod[msg.sender] = _period;
        lockedTimestamps[msg.sender] = block.timestamp;
    }

    function releaseFund() public {
        require(block.timestamp >= lockedTimestamps[msg.sender] + lockedPeriod[msg.sender], "Time is not over");
        if(lockedPeriod[msg.sender] == 1) {
            payable(msg.sender).transfer(lockedFunds[msg.sender] + reward1);
        }
        if(lockedPeriod[msg.sender] == 2) {
            payable(msg.sender).transfer(lockedFunds[msg.sender] + reward2);
        }
         if(lockedPeriod[msg.sender] == 3) {
            payable(msg.sender).transfer(lockedFunds[msg.sender] + reward3);
    }
    delete lockedFunds[msg.sender];
    delete lockedPeriod[msg.sender];
    delete lockedTimestamps[msg.sender];
}}