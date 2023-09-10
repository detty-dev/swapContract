//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenA is ERC20 {
    constructor() ERC20("tokenA", "TkA") {
        _mint(msg.sender, 1000e18);
    }
}



// develop a smart contract that enables users to performtoken swaps
//  between tokenA and tokenB in both directions, using the constant 
//  Product Market Maker formular (x * y = k) to calculate the exchange
//  rate for each swp . Additionally implement functionalities that allow 
//  users to provide liquidity to and withdraw liquidity from the
//  post(liquidity providers must contributr both tokenA and tokenB).
//  The contract should also include various view functions.
