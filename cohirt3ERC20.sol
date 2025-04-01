// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyMintableToken is ERC20, Ownable {

    constructor() ERC20("MyMintableToken", "MMT") Ownable(msg.sender) {
        _mint(msg.sender, 1000000000);
    }

    function mint(address account, uint256 amount) public onlyOwner {
        _mint(account, amount);
    }
}






contract KiratCoin {
    address private owner;
    uint public totalSupply;
    constructor(uint _totalSupply) {
        owner = msg.sender;
        totalSupply = _totalSupply;
        balanceOf[msg.sender] = _totalSupply;
    }

    modifier onlyOwner () {
        require(msg.sender == owner,"You're not owner");
        _;
    }
    mapping(address => uint) public balanceOf;

    function tranfer(address _to,uint _amount) public {
        require(balanceOf[msg.sender] >= _amount,"You don't have enough amount");
        balanceOf[_to] += _amount;
        balanceOf[msg.sender] -= _amount;


    }

    function mint(uint _amount) public onlyOwner {
        totalSupply += _amount;
        balanceOf[msg.sender] += _amount;
    }

    function mintTo(uint _amount, address _to) public onlyOwner{
        totalSupply += _amount;
        balanceOf[_to] += _amount;
    }
}