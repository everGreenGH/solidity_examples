// SPDX-License-Identifier: MIT
pragma solidity ^0.4.19;

contract SafeMath {

    /*
        Q3. 안전한 사칙연산 함수(SafeMath) 만들기
        
        CryptoZombie에서도 소개되었지만, 0.8.0버전 미만의 Solidity에서는 overflow/underflow를 자체적으로 방지할 수 없었습니다.
        이는 컨트랙트에 보안 취약점을 유발하는데, 이를 해결하기 위하여 주로 외부 library인 SafeMath를 import하여 사용합니다.
        부호 없는 8비트 정수(uint8)에서 Overflow와 underflow를 방지하는 SafeMath를 직접 구현해 보세요.
        해당 문제에서는 예외적으로 솔리디티 버전 0.4.19를 사용합니다. Compiler의 버전을 변경해 주세요.

        (참고1: Solidity 0.8.0 변화점)
        https://docs.soliditylang.org/en/v0.8.13/080-breaking-changes.html
        (참고2: Overflow/underflow로 발생하는 컨트랙트 보안 취약점)
        https://steemit.com/kr/@etainclub/53pb9t-2
    */

    /*
        실제 SafeMath 라이브러리는 internal 접근제어자를 사용하지만, 우리는 테스트를 위하여 public 접근제어자를 사용합니다.
    */
    function safeAdd(uint8 x, uint8 y) public pure returns (uint8) {      
        require((x + y) >= x, "Error: 덧셈 시 overflow 발생");
        return x + y;
    }

    function safeSub(uint8 x, uint8 y) public pure returns (uint8) {
        
        // Overflow/underflow가 발생하지 않는 뺄셈 함수(safeSub)를 작성하세요.
        // 여기에 코드를 작성하세요.

    }

    function safeMul(uint8 x, uint8 y) public pure returns (uint8) {
        
        // Overflow/underflow가 발생하지 않는 곱셈 함수(safeMul)를 작성하세요.
        // 여기에 코드를 작성하세요.

    }

    function safeDiv(uint8 x, uint8 y) public pure returns (uint8) {
        
        // Overflow/underflow가 발생하지 않는 나눗셈 함수(safeDiv)를 작성하세요.
        // 여기에 코드를 작성하세요.
        
    }

}