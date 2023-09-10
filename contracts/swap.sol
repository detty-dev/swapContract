//SPDX-License-Identifier: UNLICENSED
 pragma solidity ^0.8.19;

 import {IERC20} from "./IERC20.sol";

    
contract SwapContract {
    address public tokenA;
    address public tokenB;
    uint256 public totalReservesA;
    uint256 public totalReservesB;

    struct LiquidityProvider {
        uint256 reservesA;
        uint256 reservesB;        
    }

    mapping(address => LiquidityProvider) public liquidityProviders;

    constructor(address _tokenA, address _tokenB) {
        tokenA = _tokenA;
        tokenB = _tokenB;
    }

    function addLiquidity(uint256 amountA, uint256 amountB) external {
        IERC20(tokenA).transferFrom(msg.sender, address(this), amountA);
        IERC20(tokenB).transferFrom(msg.sender, address(this), amountB);
        LiquidityProvider storage provider = liquidityProviders[msg.sender];
        provider.reservesA += amountA;
        provider.reservesB += amountB;
        totalReservesA += amountA;
        totalReservesB += amountB;
    }

    function removeLiquidity(uint256 amountA, uint256 amountB) external {
        LiquidityProvider storage provider = liquidityProviders[msg.sender];
        require(provider.reservesA >= amountA && provider.reservesB >= amountB, "Insufficient liquidity");
        provider.reservesA -= amountA;
        provider.reservesB -= amountB;
        totalReservesA -= amountA;
        totalReservesB -= amountB;
        IERC20(tokenA).transfer(msg.sender, amountA);
        IERC20(tokenB).transfer(msg.sender, amountB);
    }

    function swapAtoB(uint256 amountA) external {
        require(amountA > 0, "Invalid amount");
        LiquidityProvider storage provider = liquidityProviders[msg.sender];
        uint256 amountB = calculateSwapAmountAtoB(amountA);
        require(provider.reservesA >= amountA && totalReservesB >= amountB, "Insufficient liquidity");
        provider.reservesA -= amountA;
        provider.reservesB += amountB;
        totalReservesA -= amountA;
        totalReservesB += amountB;
        IERC20(tokenA).transferFrom(msg.sender, address(this), amountA);
        IERC20(tokenB).transfer(msg.sender, amountB);
    }

    function swapBtoA(uint256 amountB) external {
        require(amountB > 0, "Invalid amount");
        LiquidityProvider storage provider = liquidityProviders[msg.sender];
        uint256 amountA = calculateSwapAmountBtoA(amountB);
        require(provider.reservesB >= amountB && totalReservesA >= amountA, "Insufficient liquidity");
        provider.reservesB -= amountB;
        provider.reservesA += amountA;
        totalReservesB -= amountB;
        totalReservesA += amountA;
        IERC20(tokenB).transferFrom(msg.sender, address(this), amountB);
        IERC20(tokenA).transfer(msg.sender, amountA);
    }

    function calculateSwapAmountAtoB(uint256 amountA) public view returns (uint256) {
        require(totalReservesA > 0 && totalReservesB > 0, "No liquidity");
        return (totalReservesB * amountA) / totalReservesA;
    }

    function calculateSwapAmountBtoA(uint256 amountB) public view returns (uint256) {
        require(totalReservesA > 0 && totalReservesB > 0, "No liquidity");
        return (totalReservesA * amountB) / totalReservesB;
    }

    function getLiquidityProvider(address provider) public view returns (uint256, uint256) {
        return (liquidityProviders[provider].reservesA, liquidityProviders[provider].reservesB);
    }

    function getTotalReserves() public view returns (uint256, uint256) {
        return (totalReservesA, totalReservesB);
    }
}


