require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

module.exports = {
  solidity: "0.8.0",
  networks: {
    rinkeby: {
      url: process.env.STAGING_ETH_URL,
      accounts: [process.env.STAGING_PRIVATE_KEY],
    },
    mainnet: {
      chainId: 1,
      url: process.env.PROD_ETH_URL,
      accounts: [process.env.PROD_PRIVATE_KEY],
    },
  },
};