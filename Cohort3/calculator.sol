// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Calculater {

    uint num = 0;
    constructor (uint _num) {
        num = _num;
    }

    function add (uint _value) public {
        num += _value;
    }
    function sub (uint _value) public {
        num -= _value;
    }
    function mul (uint _value) public {
        num *= _value;
    }
    function division (uint _value) public {
        require(_value != 0,"Value should not be equal to zero");
        num /= _value;
    }

    function returnVal () public view returns (uint) {
        return num;
    }

}