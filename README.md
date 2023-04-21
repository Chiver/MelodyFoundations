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
## 1. NFTMarketPlace.sol
The main contract that the 

## 2. MelodyNFT.sol 

## 3. FUTURE: MelodyToken.sol

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


# Bibliography
- https://github.com/mm6/ethereum-lab1