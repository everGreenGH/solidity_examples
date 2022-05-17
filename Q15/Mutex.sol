// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

/*
    Q15. Mutex(Mutual Exclusion, 상호 배제)

    Mutex는 재진입 공격을 방지할 수 있는 솔루션 중 하나입니다. 
    우리는 함수의 실행 과정에서 컨트랙트를 잠글 수 있는 상태 변수를 추가하여, 하나의 실행흐름만이 작동할 수 있도록 제한할 수 있습니다(Mutual Exclusion).
    아래의 코드를 통하여 Mutex 테크닉의 적용 예시를 살펴보세요.

    (참고: 운영체제의 Mutex)
    https://overcome-the-limits.tistory.com/m/339
*/    


contract Mutex {   
    mapping (address => uint) private balances;
    bool private lockBalances;

    function deposit() payable public returns (bool) {
        require(!lockBalances);
        lockBalances = true;
        balances[msg.sender] += msg.value;
        lockBalances = false;
        return true;
    }

    function withdraw(uint amount) payable public returns (bool) {
        require(!lockBalances && amount > 0 && balances[msg.sender] >= amount);
        lockBalances = true;

        (bool success, ) = msg.sender.call{value : amount}("");

        if (success) { // Check-Effects-Interaction에 어긋나는 일반적으로 취약한 방법이지만, Mutex를 통하여 재진입을 방지할 수 있습니다.
        balances[msg.sender] -= amount;
        }

        lockBalances = false;
        return true;
    }
}