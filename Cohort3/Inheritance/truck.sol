// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Vehicle.sol";
contract Car is Vehicle {
    uint8 wheels;
    constructor (string memory _brand, uint8 _wheels) Vehicle(_brand) {
        brand = _brand;
        wheels = _wheels;
    }

    function description () public pure override returns(string memory) {
        return "This is a car";
    }


}