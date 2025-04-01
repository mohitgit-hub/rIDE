// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PersonDetails {
    struct Person {
        string name;
        uint8 age;
        address personAddr;
    } 

    mapping (address => Person) public PersonDetail;

   function storePersonDetails (string memory _name, uint8 _age) public {
    PersonDetail[msg.sender] = Person (
        {
            name : _name,
            age : _age,
            personAddr : msg.sender
        }
    );
   }

   function getPerson() public view returns(string memory, uint8, address)  {
    Person memory person = PersonDetail[msg.sender];
    return (person.name, person.age, person.personAddr);
   }
}