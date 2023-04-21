/**
 * @description Deploy NFT Marketplace (dependent on melody nft.)
 * @author zwan@andrew.cmu.edu
 */

const melodyNFT = artifacts.require("./MelodyNFT.sol");
const melodyMarketPlace = artifacts.require("./MelodyMarketplace.sol");

module.exports = async function(deployer) {
  // Get the deployed instance of contract A
  const deployedNFT = await melodyNFT.deployed();

  // Deploy contract B with the address of the deployed instance of contract A
  await deployer.deploy(melodyMarketPlace, deployedNFT.address);
};