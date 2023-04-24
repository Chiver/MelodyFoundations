# MelodyFoundations
Web 3 Melody Music Platform, DBUC Final Project

# Git starter code
To update to the latest code commit, do the following: 
1. `git stash` 
2. `git pull --rebase`
3. `git stash pop`

To update your modifications to the remote branch:
**Keep yourself updated with remote branch**
1. `git stash` 
2. `git pull --rebase`
3. `git stash pop`
**Push your code**
1. `git add .`
2. `git commit -m "<describe what you did>"`
3. `git push`


# Project Structure
```
└── MelodyFoundations
    ├── README.md
    ├── apidoc.md
    ├── backend  
    │   ├── app.js
    │   ├── credentials
    │   ├── index.html
    │   ├── public
    │   └── scripts
    ├── build   
    │   └── contracts
    ├── contracts 
    │   ├── MelodyMarketplace.sol
    │   ├── MelodyNFT.sol
    │   └── Migrations.sol
    ├── migrations
    │   ├── 1_initial_migration.js
    │   ├── 2_deploy_melody_nft.js
    │   └── 3_deploy_melody_marketplace.js
    ├── package-lock.json
    ├── package.json
    ├── test
    └── truffle-config.js
```

### 1. NFTMarketPlace.sol
The main contract that controls the trading, minting of NFTs

### 2. MelodyNFT.sol 
The contract of MelodyNFT (MNFT) which implements ERC-721

### 3. Nodejs Express Backend Service
Deals with storing music file on IPFS and serving frontend content 

### 4. FUTURE: MelodyToken.sol
Governence & fans tipping. 

# Deployment
- Compile and upload contract 
`truffle migrate --reset`
- Testing with truffle console
`truffle console`
- Obtaining contract instances
```
MelodyNFT.deployed().then(function(x){ nft = x; });
MelodyMarketplace.deployed().then(function(x){ marketplace = x; });
```
- Start IPFS
`ipfs daemon`
> If not yet initialized, run `ipfs init`

# Develop Logs
- Initialize Truffle Project 
`truffle init`
- Initialize NPM and install dependencies 
`npm init`
`npm install dotenv truffle-wallet-provider ethereumjs-wallet`

## Install Dependencies 
- IPFS installed `https://docs.ipfs.tech/install/command-line/#system-requirements`
- Openzeppelin Package (For NFT Contracts)
`npm install @openzeppelin/contracts`
- Install FS for file system ops
`npm install fs`
- Install HDWallet Provider
  - @truffle/hdwallet-provider is an npm package that provides a convenient and easy-to-use way to sign transactions and manage accounts for Ethereum-based blockchains in the context of Truffle. It is especially useful when deploying smart contracts to public networks like Ethereum Mainnet, Ropsten, or other testnets, and when you want to use external wallets like MetaMask, Ledger, or Trezor.
`npm install @truffle/hdwallet-provider@1.2.3`
- Install body parser for parsing request body in express
`npm install express body-parser`


# Demo Instructions 
## Start Ganache 
1. Open Ganache
2. Click Quickstart

## Deployment of Contract
1. Open Remix
2. Create 2 Contracts on Remix
3. Deploy `MelodyNFT.sol`
4. Deploy `MelodyMarketplace.sol` using `MelodyNFT.sol`'s address


## Test out functionalities
1. Get Alice, Bob, Charlie's account address
2. Alice stores the music `sample_music_alice.mp3` on ipfs
3. Alice gets the metadata uri of `sample_music_alice.mp3` by runing 
```
sh ./backend/scripts/store_nft.sh ./backend/credentials/music/sample_music_alice.mp3 "SONG_OF_ALICE" "DESCRIPTION_OF_SONG_OF_ALICE"
```
4. Alice mints the nft of a song `SONG_ALICE` using the uri from last step
```
[
	{
		"from": "0x2727f5cC2543995D8d4e8E4A4355267Db80Ce94F",
		"topic": "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef",
		"event": "Transfer",
		"args": {
			"0": "0x0000000000000000000000000000000000000000",
			"1": "0x51Ab3223FCd4FE77969184524c5D3BD65E08bab6",
			"2": "1",
			"from": "0x0000000000000000000000000000000000000000",
			"to": "0x51Ab3223FCd4FE77969184524c5D3BD65E08bab6",
			"tokenId": "1"
		}
	}
]
```
5. Could run `ownerOf` with tokenId above to check that Alice's address owns the nft
```
{
	"0": "address: 0x51Ab3223FCd4FE77969184524c5D3BD65E08bab6"
}
```
6. Now we want to list the nft for trading. In `MelodyMarketplace.sol`, first we grant the marketplace contract the privilage to manage all of Alice's NFTs by running `setApprovalForAll(MARKETPLACE_ADDR, true)`
```
[
	{
		"from": "0x2727f5cC2543995D8d4e8E4A4355267Db80Ce94F",
		"topic": "0x17307eab39ab6107e8899845ad3d59bd9653f200f220920489ca2b5937696c31",
		"event": "ApprovalForAll",
		"args": {
			"0": "0x51Ab3223FCd4FE77969184524c5D3BD65E08bab6",
			"1": "0xB09c776409fd0C8417Fcb2B38BaB89aa58c84811",
			"2": true,
			"owner": "0x51Ab3223FCd4FE77969184524c5D3BD65E08bab6",
			"operator": "0xB09c776409fd0C8417Fcb2B38BaB89aa58c84811",
			"approved": true
		}
	}
]
```
7. Now Alice want to list the NFT for trading, we run `listToken(1, 12)`, which lists tokenId of 1 of 12 ETH's price. 
```
[
	{
		"from": "0x2727f5cC2543995D8d4e8E4A4355267Db80Ce94F",
		"topic": "0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925",
		"event": "Approval",
		"args": {
			"0": "0x51Ab3223FCd4FE77969184524c5D3BD65E08bab6",
			"1": "0xB09c776409fd0C8417Fcb2B38BaB89aa58c84811",
			"2": "1",
			"owner": "0x51Ab3223FCd4FE77969184524c5D3BD65E08bab6",
			"approved": "0xB09c776409fd0C8417Fcb2B38BaB89aa58c84811",
			"tokenId": "1"
		}
	}
]
```






## Truffle Console 
1. Enter truffle
`truffle console`

2. Initialize `web3` package 
```
var Web3 = require('web3');
var web3 = new Web3(new Web3.providers.HttpProvider('http://127.0.0.1:7545'));
web3.isConnected();
```


# Bibliography
- https://github.com/mm6/ethereum-lab1