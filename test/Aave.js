const { ethers, network } = require("hardhat");
const { expect } = require("chai");

const { LENDING_POOL_PROVIDER_ADDRESS, AAVE_V2_ADDRESS, AAVE_ATOKEN_ADDRESS } = network.config.constants;

describe("AAVE V2 POC Tests", function () {
    let deployer;
    let account1;
    let account2;

    let aavePoc;
    let aavePocAddress;

    beforeEach(async function () {
        // Retrieve the accounts
        [deployer, account1, account2] = await ethers.getSigners();
        // Compile the contract
        const AavePOC = await ethers.getContractFactory("Aave");
        // Deploy the contract
        aavePoc = await AavePOC.deploy(AAVE_ATOKEN_ADDRESS, LENDING_POOL_PROVIDER_ADDRESS, AAVE_V2_ADDRESS);

        await aavePoc.deployed();

        // Get the address of the DoraToken contract
        aavePocAddress = await aavePoc.getDoraTokenAddress();
    });

    describe("stakeETH func", function () {});

    describe("depositETH func", function () {});
});
