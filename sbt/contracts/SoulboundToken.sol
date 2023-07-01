// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SoulboundToken is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    /**
     * @dev Constructor function.
     */
    constructor() ERC721("Fantom SBT", "FSBT") {
        _set
    }

    /**
     * @dev Modifier to check if the token is transferable.
     * @param from Address sending the token.
     * @param to Address receiving the token.
     * @param tokenId ID of the token.
     * @param batchSize Number of tokens being transferred.
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal override(ERC721) {
        require(from == address(0), "Token not transferable");
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    /**
     * @dev Mint a new token and assign it to the specified address.
     * @param to Address to receive the minted token.
     */
    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    /**
     * @dev Burn a token.
     * @param tokenId ID of the token to burn.
     */
    function _burn(
        uint256 tokenId
    ) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    /**
     * @dev Get the URI of a token.
     * @param tokenId ID of the token.
     * @return The URI of the token.
     */
    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    /**
     * @dev Sets the base URI for token metadata.
     * @param baseURI The base URI to be set.
     */
    function setBaseURI(string memory baseURI) external onlyOwner {
        _baseURI = baseURI;
    }

    /**
     * @dev Retrieves the base URI for token metadata.
     * @return The base URI.
     */
    function _baseURI() internal view override returns (string memory) {
        return _baseURI;
    }
}
