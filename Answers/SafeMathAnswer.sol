// SPDX-License-Identifier: MIT
pragma solidity ^0.4.19;

contract SafeMath {

    function safeAdd(uint8 x, uint8 y) public pure returns (uint8) {
        require((x + y) >= x);
        return x + y;
    }

    function safeSub(uint8 x, uint8 y) public pure returns (uint8) {
        require(x >= y);
        return x - y;
    }

    function safeMul(uint8 x, uint8 y) public pure returns (uint8) {
        require((x * y) >= x);
        return x * y;
    }

    // 나눗셈에서는 overflow / underflow가 발생하지 않습니다. y = 0일 시 Solidity에서 자체적으로 error를 발생시킵니다.
    function safeDiv(uint8 x, uint8 y) public pure returns (uint8) {
        return x / y;
    }

}