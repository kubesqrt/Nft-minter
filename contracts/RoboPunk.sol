// SPDX-Licence-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC721/ERC721/.sol';
import '@openzeppelin/contracts/access/Owanble.sol';

contract RoboPunksNFT is ERC721, Ownable {
    uint public mintPrice;
    uint256 public totalSupply;
    uint256 public maxSupply;
    uint256 public maxPerWallet;
    bool public isPublicMintEnabled;
    string internal baseTokenUri;
    address payable public withdrawWallet;
    mapping(address => uint256) public walletMints;
 

    constructor() payable ERC721('RoboPunks', RP){
        mintPrice = 0.02 ether;
        totalSupply = 0;
        maxSupply = 1000;
        maxPerWallet - 3;
    }

    function setIsPublicMintEnabled(bool isPublicMintEnabled_) external onlyOwner {
        isPublicMintEnabled = isPublicMintEnabled_;    
    }

    function setBaseTokenUri(string calldata baseTokenUri_) external onlyOwner {
        baseTokenUri = baseTokenUri_;
    }

    function tokenUri(uint256 tokenId_) public view override returns (string memory){
        require(_exists(tokenId_), 'Token does not exist');
        return string(abi.encodePacked(baseTokenUri, String.toString(tokenId_), "json"));
    }

    function withdraw() external onlyOwner {
        (bool success, ) = withdrawWallet.call{ value: address(this).balance }(' ');
        require(success, 'withdraw failed');
    }

    function mint(uint256 quantity_) public payable {
        require(isPublicMintEnabled, 'minting not enabled');
        require(msg.value == quanitity_ * mint price, 'wrong mint value');
        require(total supply * quantity_ <= maxSupply, 'sol out');
        require(walletMints[msg.sender] + quantity_ <= maxPerWallet, ' exceeded max wallet');
    }
}