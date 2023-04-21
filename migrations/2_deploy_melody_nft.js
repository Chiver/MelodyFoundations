/**
 * @description Deploy Melody NFT
 * @author zwan@andrew.cmu.edu
 */


var melodyNFT = artifacts.require("./MelodyNFT.sol");

module.exports = function(deployer) {
  deployer.deploy(melodyNFT);
};