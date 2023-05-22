require("@nomicfoundation/hardhat-toolbox")
require("@nomiclabs/hardhat-etherscan")
require("dotenv/config")
const constants = require("./constants")

// constants
const { GOERLI_PRIVATE_KEY, ACCOUNT_PRIVATE_KEY, ETHERSCAN_API_KEY } = process.env



module.exports = {
    networks: {
        hardhat: {
            forking: {
                url: `https://eth-goerli.g.alchemy.com/v2/${GOERLI_PRIVATE_KEY}`,
            },
            chainId: 31337,
            constants: constants.hardhat
        },
        goerli: {
            url: `https://eth-goerli.g.alchemy.com/v2/${GOERLI_PRIVATE_KEY}`,
            accounts: [ACCOUNT_PRIVATE_KEY],
            constants: constants.goerli
        },
    },
    etherscan: {
        apiKey: ETHERSCAN_API_KEY
    },
    solidity: "0.8.18",
}
