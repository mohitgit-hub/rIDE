// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MoncockOG is ERC721A, Ownable {

    // config
    constructor(address initialOwner) ERC721A("Moncock OG", "MONCOCKOG") Ownable(initialOwner) {}
    uint256 public START_ID = 1;

    bool public mintEnabled = true;
    string public baseURI = "https://moncock.github.io/launchpad/images/origin.png";

    // start token id
    function _startTokenId() internal view virtual override returns (uint256) {
        return START_ID;
    }

    // metadata
    function setBaseURI(string calldata _newBaseURI) external onlyOwner {
        baseURI = _newBaseURI;
    }
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        string memory jsonPreImage = string.concat(
            string.concat(
                string.concat('{"name": "Moncock OG #', Strings.toString(tokenId)),
                '","description":"We are Moncock","image":"'
            ),
            baseURI
        );
        string memory jsonPostImage = '"}';
        return
            string.concat(
                "data:application/json;utf8,",
                string.concat(jsonPreImage, jsonPostImage)
            );
    }

    // toggle sale
    function toggleSale() external onlyOwner {
        mintEnabled = !mintEnabled;
    }

    // mint
    function mint(uint quantity, bytes32[] calldata _merkleProof) external {
        quantity = 1; // force mint single NFT
        require(mintEnabled, "Sale is not enabled");
        
        _mint(msg.sender, quantity);
    }
    function adminMint(uint quantity) external onlyOwner {
        _mint(msg.sender, quantity);
    }

    // aliases
    function numberMinted(address owner) external view returns (uint256) {
        return _numberMinted(owner);
    }
    function remainingSupply() external pure returns (uint256) {
        return 0;
    }

}

