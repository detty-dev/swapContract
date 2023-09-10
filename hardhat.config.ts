import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  
  solidity: "0.8.19",
  // networks:{
  // base: {
  //   url: process.env.BASERPC,
  //   //@ts-ignore
  //   accounts: [process.env.PRIVATEKEY], 
  //   },
// },
     networks: {
      // sepolia: {
      //   url:process.env.SEPOLIARPC,
      //   // @ts-ignore
      //   accounts:[process.env.PRIVATEKEY]
      // },
        // hardhat: { 
        //   forking: {
        //     url: "https://eth-sepolia.g.alchemy.com/v2/XUsm-s7iPJv-VC3iR744q3TzgI86BBzT",
        //   }
        // }
      },
      etherscan: {
        apiKey: process.env.ETHERSCAN_API_KEY,
      },
}

export default config;