
require("@nomiclabs/hardhat-waffle");
const dotenv = require("dotenv");
dotenv.config();

/** @type import('hardhat/config').HardhatUserConfig */
task("accounts", "print the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ether.getSigners();

  for (const account of accounts) {
    console.log(account.address)
  }
})
module.exports = {
  solidity: "0.8.17",
  networks: {
    sepolia: {
      url: process.env.REACT_APP_RINKEBY_RPC_URL,
      accounts: [process.env.REACT_APP_PRIVATE_KEY]
    }

  }
};
