// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract HelloWorld {

    /*
        Q1: Remix IDE와 친해지기
        
        먼저 Remix IDE와 친해져 볼까요? Remix IDE는 온라인에서 쉽게 스마트 컨트랙트를 컴파일 및 배포해 볼 수 있는 IDE입니다.

        (Remix IDE)
        https://remix.ethereum.org/

        왼쪽 바에는 Remix IDE가 제공하는 여러 가지 기능들이 있습니다.
        1) 먼저, Contract 폴더에 HelloWorld.sol 컨트랙트를 생성하세요. 그리고 이 소스코드를 복사한 후 저장하세요.
        2) HelloWorld.sol 컨트랙트를 컴파일하세요. Remix는 다양한 솔리디티 컴파일러 버전을 지원합니다. 컴파일러 버전을 0.8.11로 설정한 후 컴파일하세요.
        3) HelloWorld.sol 컨트랙트를 배포하세요. 아래의 "deployed contract"를 통하여 트랜잭션을 생성하고 컨트랙트의 정보를 확인할 수 있습니다.
           Hi 버튼을 눌러 블록체인에 배포된 Hi 문자열 데이터를 확인하세요. newHi 버튼을 눌러 함수 newHi를 실행하고, 다시 Hi 버튼을 눌러 값이 변경된 것을 확인하세요.
    */

    string public hi = "Hello World!";

    function newHi() public returns (bool) {
        hi = "Blockchain Valley!";
        return true;
    }

}