// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract MathAnswer {

    function add(uint256 x, uint256 y) public pure returns (uint256) {
        return x + y;
    }
    
    function sub(uint256 x, uint256 y) public pure returns (uint256) {
        if(x >= y) return x - y;
        else return y - x;
    }

    function mul(uint256 x, uint256 y) public pure returns (uint256) {
        return x * y;
    }

    function div(uint256 x, uint256 y) public pure returns (uint256) {
        return x > y ? x / y : y / x;
    }
}