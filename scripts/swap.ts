import {ethers} from "hardhat";

async function main() {
    const tokenAaddress = '0x5FbDB2315678afecb367f032d93F642f64180aa3';
    const tokenBaddress = '0x5FbDB2315678afecb367f032d93F642f64180aa3';
    const TokenA = await ethers.getContractFactory("TokenA");
    const TokenB = await ethers.getContractFactory("TokenB");

    const SwapContract = await ethers.getContractFactory("SwapContract");
    const swap = await SwapContract.deploy(tokenAaddress, tokenBaddress);
    console.log("SwapContract deployed to:", swap.target);
}
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });

 