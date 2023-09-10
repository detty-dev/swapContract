import {ethers} from "hardhat";

async function main() {
    const tokenA = await ethers.deployContract("TokenA", [], {});
          await tokenA.waitForDeployment();
    
    const tokenB = await ethers.deployContract("TokenB", [], {});
          await tokenB.waitForDeployment();  
            
          console.log(tokenA.target);
          console.log(tokenB.target);  
}

 
    // We recommend this pattern to be able to use async/await everywhere
    // and properly handle errors.
    main().catch((error) => {
      console.error(error);
      process.exitCode = 1;
    });
    