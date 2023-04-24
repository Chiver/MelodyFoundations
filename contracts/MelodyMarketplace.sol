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

    /*
     * @brief List the token for public trading. 
     */
    function listToken(uint256 _tokenId, uint256 _price) external {
        require(nftContract.ownerOf(_tokenId) == msg.sender, "Not the token owner");
        nftContract.approve(address(this), _tokenId);

        for (uint256 i=0; i<nextListingId; i++) {
            if(listings[i].tokenId == _tokenId){
                listings[i].active = true; 
                listings[i].seller = msg.sender; 
                listings[i].price = _price; 
                return; 
            }
        }
        nextListingId++;
        listings[nextListingId] = Listing({
            tokenId: _tokenId,
            seller: msg.sender,
            price: _price,
            active: true
        });
    }

    /*
     * @brief Cancel the listing for an NFT. 
     */
    function cancelListing(uint256 _listingId) external {
        require(listings[_listingId].seller == msg.sender, "Not the listing owner");
        require(listings[_listingId].active, "Listing is not active");

        nftContract.approve(address(this), listings[_listingId].tokenId);
        listings[_listingId].active = false;
    }

    /*
     * @brief Buy a listed token. 
    */ 
    function buyToken(uint256 _listingId) external payable {
        require(listings[_listingId].active, "Listing is not active");
        require(msg.value >= listings[_listingId].price, "Insufficient funds");

        nftContract.transferFrom(listings[_listingId].seller, msg.sender, listings[_listingId].tokenId);
        // Transfers Ether from function caller's address to the seller's address. 
        payable(listings[_listingId].seller).transfer(msg.value);
        // Sets active to false so that no other people can instantly buy the NFT.
        // Need owner to make that active for further trade. 
        listings[_listingId].active = false;
    }

    /*
     * @brief Change price of NFT if you are owner. 
    */
    function changePrice(uint256 _listingId, uint256 _newPrice) external {
        require(listings[_listingId].seller == msg.sender, "Not the listing owner");
        require(listings[_listingId].active, "Listing is not active");

        listings[_listingId].price = _newPrice;
    }

    // Implement auction-related functions
    function getListingByTokenId(uint256 tokenId) public view returns (uint256 listingId, address seller, uint256 price, bool isActive) {
        for (uint256 i = 0; i < nextListingId; i++) {
            if (listings[i].tokenId == tokenId) {
                return (i, listings[i].seller, listings[i].price, listings[i].active);
            }
        }
        revert("Listing not found for the given token ID");
    }

    function getAllActiveListings() public view returns (Listing[] memory resultListings) {

        // Create an array to store the active listings
        resultListings = new Listing[](nextListingId);

        // Populate the activeListings array
        for (uint256 i = 0; i < nextListingId; i++) {
            resultListings[i] = listings[i];
        }
    }
}
