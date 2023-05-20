const { ethers, network, hardhat } = require("hardhat");

async function main() {
  const { formatEther, parseEther } = ethers.utils;
  const [deployer] = await ethers.getSigners();
  const AaveContract = await ethers.getContractFactory("Aave");
  const aaveContract = await AaveContract.deploy();
  await aaveContract.deployed();

  console.log("AaveContract deployed to:", aaveContract.address);

  const TokenBalance = await aaveContract.getBalance(deployer.address);
  console.log("Token Balance:", TokenBalance.toString());
  const TokenBalance1 = await aaveContract.getBalance(
    "0x41CfD383011a136FBc3E58b932F1F5EBdcC58bf2"
  );
  console.log("Token Balance1:", formatEther(TokenBalance1.toString()));

  const LendingPoolAddress = await aaveContract.getLendingPoolAddress();
  console.log("Lending Pool Address:", LendingPoolAddress);

  const EthBalanceOfDeployer = await ethers.provider.getBalance(
    deployer.address
  );
  console.log(
    "ETH Balance of Deployer before staking:",
    formatEther(EthBalanceOfDeployer.toString())
  );

  const stakeEth = await aaveContract
    .connect(deployer)
    .stakeEth({ value: parseEther("5") });
  console.log("Stake ETH:", !!stakeEth?.hash);

  const EthBalanceOfDeployerAfterStaking = await ethers.provider.getBalance(
    deployer.address
  );
  console.log(
    "ETH Balance of Deployer after staking:",
    formatEther(EthBalanceOfDeployerAfterStaking.toString())
  );

  const ATokenBalance = await aaveContract.getBalance(aaveContract.address);
  console.log("AToken Balance:", formatEther(ATokenBalance.toString()));

  // const approve = await aaveContract.connect(deployer).approveToken(parseEther("2"));

  // console.log("Approve:", !!approve?.hash);

  const allowance = await aaveContract.allowance();
  console.log("Allowance:", formatEther(allowance.toString()));

  const EthBalanceOfSampleBeforeWithdraw = await ethers.provider.getBalance(
    aaveContract.address
  );

  console.log(
    "ETH Balance of Contract before withdraw:",
    formatEther(EthBalanceOfSampleBeforeWithdraw.toString())
  );

  const withdrawEth = await aaveContract
    .connect(deployer)
    .withdrawEth(parseEther("1"));

  console.log("Withdraw ETH:", !!withdrawEth?.hash);

  const EthBalanceOfSampleAfterWithdraw = await ethers.provider.getBalance(
    aaveContract.address
  );

  console.log(
    "ETH Balance of Contract after withdraw:",
    formatEther(EthBalanceOfSampleAfterWithdraw.toString())
  );
}

// Run the deployment script
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
