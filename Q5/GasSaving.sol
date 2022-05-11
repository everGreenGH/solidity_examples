// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract GasSaving {

    /*
        Q5. 가스비 절약하기

        스마트 컨트랙트에서 가스비를 절약하는 코딩 패턴은 아주 중요합니다. 
        가스비 절약이 매우 중요한 나머지, 스마트 컨트랙트를 작성할 때는 다른 프로그래밍 언어의 일반적인 코딩 패턴과 벗어나는 코딩 패턴을 사용할 때도 있습니다.
        아래의 가스 절약 테크닉을 사용하여, sumIfEvenAndLessThan99_2 함수를 구현하고, 가스비가 절감되었는지 확인하세요.
        Remix IDE의 plugin(하단부)에서 Gas Profiler를 활성화하여, 트랜잭션의 가스비를 쉽게 확인할 수 있습니다.

        1) 함수 선언부의 memory를 calldata로 교체하세요. memory와 calldata의 차이점에 대해서는 아래 링크를 참고하세요.
        2) 상태 변수에 접근하는 것은 높은 가스비를 소비합니다. total 변수의 값을 복사하여 _total 변수를 선언하고, 함수의 마지막에서 total 변수에 _total 변수를 대입하세요.
           이는 반복문에서의 불필요한 상태 변수 접근 횟수를 줄여, 가스비를 줄일 수 있도록 합니다.
        3) 반복문을 최대한 간결하게 만드세요.
        4) 후치 증가 연산자(i++)를 전치 증가 연산자(++i)로 교체하세요.
        5) 배열의 길이를 계산하는 array.length의 계산은 높은 가스비를 소모합니다. 
           nums 배열의 길이를 저장하는 len 변수를 선언하고 초기화한 후, 반복문에서 len 변수를 사용하세요.

        각각의 테크닉을 사용할 때 왜 가스비가 절감되는지 생각해 보세요. 이 외에도 가스비를 절감하는 테크닉이 있으면, 사용하셔도 좋습니다.

        (참고: 언제 memory를 사용하고, 언제 calldata를 사용하나요?)
        https://ethereum.stackexchange.com/questions/74442/when-should-i-use-calldata-and-when-should-i-use-memory
    */

    uint public total;

    function sumIfEvenAndLessThan99(uint[] memory nums) external {
        for (uint i = 0; i < nums.length; i++) {
            bool isEven = nums[i] % 2 == 0;
            bool isLessThan99 = nums[i] < 99;
            if (isEven && isLessThan99) {
                total += nums[i];
            }
        }
    }

    function sumIfEvenAndLessThan99_2(uint[] calldata nums) external {
        
        // 여기에 코드를 작성하세요.


    }
}