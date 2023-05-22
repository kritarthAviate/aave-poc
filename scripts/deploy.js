const { ethers, network, hardhat } = require("hardhat");

async function main() {
    const { LENDING_POOL_PROVIDER_ADDRESS, AAVE_V2_ADDRESS, AAVE_ATOKEN_ADDRESS } = network.config.constants;

    const { formatEther, parseEther } = ethers.utils;
    const [deployer] = await ethers.getSigners();
    const AaveContract = await ethers.getContractFactory("Aave");
    const aaveContract = await AaveContract.deploy(AAVE_ATOKEN_ADDRESS, LENDING_POOL_PROVIDER_ADDRESS, AAVE_V2_ADDRESS);
    await aaveContract.deployed();

    console.log("AaveContract deployed to:", aaveContract.address);
}

// Run the deployment script
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
