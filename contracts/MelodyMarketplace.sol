/** SPDX-License-Identifier: UNLICENSED
 * @author: zwan@andrew.cmu.edu
 * 2023-04-21
 */ 

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract MelodyMarketplace {
    struct Listing {
        uint256 tokenId;
        address seller;
        uint256 price;
        bool active;
    }

    IERC721 public nftContract;
    uint256 private nextListingId;
    mapping(uint256 => Listing) private listings;
    

    /*
    This contract should be initialized by `MelodyNFT` Contract Instance.
    */
    constructor(address _nftContractAddress) {
        nftContract = IERC721(_nftContractAddress);
    }

    function listToken(uint256 _tokenId, uint256 _price) external {
        require(nftContract.ownerOf(_tokenId) == msg.sender, "Not the token owner");
        nftContract.approve(address(this), _tokenId);

        nextListingId++;
        listings[nextListingId] = Listing({
            tokenId: _tokenId,
            seller: msg.sender,
            price: _price,
            active: true
        });
    }

    function cancelListing(uint256 _listingId) external {
        require(listings[_listingId].seller == msg.sender, "Not the listing owner");
        require(listings[_listingId].active, "Listing is not active");

        nftContract.approve(address(this), listings[_listingId].tokenId);
        listings[_listingId].active = false;
    }

    function buyToken(uint256 _listingId) external payable {
        require(listings[_listingId].active, "Listing is not active");
        require(msg.value >= listings[_listingId].price, "Insufficient funds");

        nftContract.transferFrom(listings[_listingId].seller, msg.sender, listings[_listingId].tokenId);
        payable(listings[_listingId].seller).transfer(msg.value);
        listings[_listingId].active = false;
    }

    function changePrice(uint256 _listingId, uint256 _newPrice) external {
        require(listings[_listingId].seller == msg.sender, "Not the listing owner");
        require(listings[_listingId].active, "Listing is not active");

        listings[_listingId].price = _newPrice;
    }

    // Implement auction-related functions
}
