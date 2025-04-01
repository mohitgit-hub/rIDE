// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NamingService {
    mapping (address => string) public names;
    function registerName(string memory _name) public {
        names[msg.sender] = _name;
    }
    function getName(address _address) public view returns(string memory){
        return names[_address];
    }
}