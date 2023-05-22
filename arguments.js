const { ethers, network, hardhat } = require("hardhat");

const { LENDING_POOL_PROVIDER_ADDRESS, AAVE_V2_ADDRESS, AAVE_ATOKEN_ADDRESS } = network.config.constants;

module.exports = [
  AAVE_ATOKEN_ADDRESS, LENDING_POOL_PROVIDER_ADDRESS, AAVE_V2_ADDRESS
]