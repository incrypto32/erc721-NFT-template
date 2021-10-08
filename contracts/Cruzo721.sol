//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "hardhat/console.sol";

/// @title The Cruzo721 NFT Contract implementing ERC721 standard
/// @notice This contract can will be the token for Cruzo NFT's
/// @dev Only the contract owner can mint the tokens
contract Cruzo721 is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    string private baseURI;

    // address contractAddress;

    // constructor(address marketplaceAddress) ERC721("Cruzo Tokens", "CRZ") {
    //     contractAddress = marketplaceAddress;
    // }

    constructor() ERC721("Cruzo", "CRZ") {}

    /**
     * @dev _baseURI() function overriden from ERC721
     * This will act as the base URI of the token
     * Actual `tokenURI` will be concatention of `_baseURI()` and `tokenURI` 
     */
    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    /**
     * @notice This function can be used to mint a token to a specific address
     * @param tokenURI is the metadata
     * @param to - The to address to which the token is to be minted
     * @dev Mint a token with a `tokenURI` to `to` address
     */
    function mintTo(string memory tokenURI, address to)
        public
        onlyOwner
        returns (uint256)
    {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        _mint(to, newItemId);
        _setTokenURI(newItemId, tokenURI);

        // setApprovalForAll(contractAddress, true);
        return newItemId;
    }
}
