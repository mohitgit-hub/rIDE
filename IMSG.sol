// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// Interface of messge contract
interface IMSG {
    function setMessage (string memory _message) external;
    function getMessage ( ) external view returns(string memory);
}

// Calling function of InterFace Contract
contract MessageProxy{
    address private contractAddress;

    constructor(address _contractAddress) {
        contractAddress = _contractAddress;
    }

    function setMessageFromOtherContract (string memory _message) public {
        IMSG(contractAddress).setMessage(_message);
    }

    function getMessageFromOtherContract ( ) public view returns(string memory){
        return (IMSG(contractAddress).getMessage());
    }

}