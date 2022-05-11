// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract AdvancedMath {

    /*
        Q4: Power(제곱)함수와 Sqrt(제곱근)함수 만들기

        좀 더 복잡한 연산 함수를 만들어 볼까요? 아래의 설명을 따라서 power, sqrt 함수를 만들어 보세요.
        모든 함수에 대하여 적절한 접근제어자를 추가해야 합니다.
    */    

    function power(uint256 x, uint256 y) returns (uint256) {

        /*
            "**" 연산자는 Solidity 및 다른 프로그래밍 언어에서 제곱 연산을 수행하는 연산자입니다. 
            ** 연산자를 사용하지 않고, 제곱 연산(x의 y제곱)을 구현해 보세요. 반복문을 사용하여 구현하세요.
        */

        // 여기에 코드를 작성하세요.

    }

    function sqrt(uint256 x) returns (uint256) {

        /*
            Challenge: Solidity에서는 아직 부동 소수점 연산을 완벽하게 지원하지 않습니다. 
            주어진 수에 대하여 근사적으로 제곱근을 구하는 알고리즘으로는 Babylonian Method가 있습니다. 
            가장 유명한 DEX인 Uniswap에서도 Babylonian Method를 통하여 제곱근을 계산하는 라이브러리를 사용합니다. 
            Babylonian Method를 사용하여, 주어진 정수 x에 대한 근사 제곱근(y)을 반환하는 함수를 구현하세요.
            
            알고리즘 참고: (https://s-realstory.tistory.com/17)
        */

        // 여기에 코드를 작성하세요.

    }

}