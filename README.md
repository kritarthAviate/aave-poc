## AAVE V2 POC

View contract on [Goerli Etherscan](https://goerli.etherscan.io/address/0x45bF4e99eEe2e52823443fe5B5544782Fe7b4FfC#code). Integrates AAVE V2 contract to deposit and withdraw ETH using WETH Gateway.

[Github repo link to frontend](https://github.com/kritarthAviate/aave-frontend)

## Set up

The hardhat config is set up to deploy it on Goerli or Goerli fork.

-   copy `.env.exmaple` contents to `.env` file and add the relevant keys.

```
$npm install
$npx hardhat compile
$npx hardhat test
$npx hardhat run --network NETWORK_NAME scripts/deploy.js
$npx hardhat verify --network NETWORK_NAME DEPLOYED_CONTRACT_ADDRESS --constructor-args arguments.js
```
