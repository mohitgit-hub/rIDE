// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract MoneyManager {
    uint256 private totalAmount;
    mapping (address=> uint256) public userAmount;

    function depositEther( ) public payable {
        totalAmount += msg.value;  // totalAmount = totalAmount + msg.value
        userAmount[msg.sender] += msg.value; // userAmount[msg.sender] = userAmount[msg.sender]+msg.value
    }

    function withdrawEther(uint256 _amount) public payable {
        require(userAmount[msg.sender] >= _amount, "not enough amount to withdraw");
        payable(msg.sender).transfer(_amount);
        userAmount[msg.sender] += _amount; 
    }
    
}