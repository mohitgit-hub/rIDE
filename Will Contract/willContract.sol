// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract WillContract {
    address public parent;
    address public child;
    uint deployTimeStamp;
    uint public totalAmount;
    constructor(address _child) {
        deployTimeStamp = block.timestamp;  //3,15,36,000
        parent = msg.sender;
        child = _child;

    }
    function depositEther( ) public payable {
        require(msg.sender == parent,"You can't send money");
        totalAmount += msg.value;
    }

    function withdrawEther() public payable  {
        require(msg.sender == child,"You're not child");
        require(lastcall<= lastcall+60,"Time of ping is in limit");
        payable(msg.sender).transfer(totalAmount);
        totalAmount = 0;
    } 

    uint public lastcall;
    function pingByOwner() public returns(uint256) {
        lastcall = block.timestamp;
        return lastcall;
        }

}