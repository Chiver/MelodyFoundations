# Melody API Documentation 

## MelodyNFT Contract 

**Mint A New NFT**
`function mint(address recipient, string memory tokenURI) public returns (uint256)`
- recipient: user address 
- tokenURI: the file hash of the metadata of the music on IPFS 
- return: tokenId

**Transfer NFT Ownership**
`function transferFrom(address from, address to,uint256 tokenId)`
- from: user address
- to: user address
- tokenId: tokenId

**Get list of TokenIDs of NFT that address owns**
`function tokensOfOwner(address owner) external view returns (uint256[] memory)` 
- owner: user address
- return: list of tokenIds. 

## MelodyMarketplace Contract 

`function listToken(uint256 _tokenId, uint256 _price)`

`function cancelListing(uint256 _listingId)`

`function buyToken(uint256 _listingId)`

`function changePrice(uint256 _listingId, uint256 _newPrice)`

## Express Backend

`POST /store_nft`
- Body Params:
  - music_path    
  - nft_name
  - nft_description
- Return: 
  - IPFS url of the music metadata 

