// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PersonDetails {
    struct Person {
        string name;
        uint age;
        address personAddr;
    } 

    Person p1;

     constructor(string memory _name, uint _age) {
        p1.name = _name;
        p1.age = _age;
        p1.personAddr = msg.sender;
    }

    function getPersonDetails() public view returns(string memory,uint , address) {
        return (p1.name, p1.age, p1.personAddr);
    }
}