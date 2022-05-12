// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract AdvancedMath {

    function power(uint256 x, uint256 y) public pure returns (uint256) {

        uint256 result = 1;

        for(uint256 i = 0; i < y; ++i) {
            result *= x;
        }
        
        return result;
    }

    function sqrt(uint256 x) public pure returns (uint256) {
        /*
            Babylonian Method에 의해, 점화식 x(n+1) = (x(n) + S / x(n)) / 2 를 반복할 시 S의 제곱근에 가까운 값을 얻을 수 있습니다.
            아래의 예시 답안을 보면서, 변수 result와 tmp의 변화 과정을 직접 적어 보면 알고리즘을 쉽게 이해할 수 있습니다.
        */
        
        uint256 result;

        if (x > 3) {
            result = x;
            uint256 tmp = x / 2 + 1;
            while (x < result) {
                result = tmp;
                tmp = (tmp + (x / tmp)) / 2;
            }
        } else if (x != 0) {
            result = 1;
        } else {
            result = 0;
        }
        
        return result;
    }

}