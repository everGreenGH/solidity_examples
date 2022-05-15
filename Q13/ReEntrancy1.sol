// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

/*
    Q13. 재진입 취약성 (1)

    스마트 컨트랙트에서 중요한 것은 다른 외부 컨트랙트의 코드를 호출하거나 활용할 수 있다는 것입니다. 
    이때 이러한 외부 호출은 제어 흐름을 가져가, 함수가 예상하지 않은 방향의 데이터 변경을 가져올 수 있습니다.
    예를 들어, 스마트 컨트랙트가 알 수 없는 주소로 이더를 보내는 것을 가정합니다. 이 때 공격자는 fallback() 기능을 이용하여 공격자의 주소로 이더를 보낼 때 악의적 코드를 호출합니다.
    공격자의 악의적 컨트랙트는 보안 취약점을 가지는 컨트랙트의 함수를 호출하고, 함수 호출이 완료되기 전에 "재진입(re-entrace)"하여 반복적으로 호출합니다.
    이를 재진입 공격이라고 하며, 이는 유명한 The DAO 해킹 사건에 사용되어 해당 DAO의 붕괴를 초래하였습니다.

    우선, 단일 함수에 대한 재진입에 취약한 함수를 살펴봅시다.
    
    mapping (address => uint) private userBalances;

    // 취약한 함수
    function withdrawBalance() public {
        uint amountToWithdraw = userBalances[msg.sender];
        (bool success, ) = msg.sender.call{value: amountToWithdraw}("");
        require(success);
        userBalances[msg.sender] = 0;
    }

    사용자의 잔액은 함수가 끝나기 전까지 0으로 설정되지 않습니다. 
    이때 공격자는 해당 함수에 재진입하여 해당 함수를 계속 호출할 수 있고(아직 잔액이 0이 아니기 때문), 계속하여 잔액을 인출할 수 있습니다.
    해당 공격을 방지하는 가장 좋은 방법은, 함수의 모든 내부 작업을 완료할 때까지 외부 함수 및 외부 함수를 호출하는 함수를 호출하지 않는 것입니다. 아래의 예시를 참고하세요.

    mapping (address => uint) private userBalances;

    function withdrawBalance() public {
        uint amountToWithdraw = userBalances[msg.sender];

         // 외부 함수를 호출하기 전에, 해당 계정의 잔액을 0으로 설정합니다.
        userBalances[msg.sender] = 0;

        (bool success, ) = msg.sender.call{value: amountToWithdraw}("");
        require(success);
    }

    아래 컨트랙트의 getFirstWithdrawlBonus는 재진입 공격에 취약한 함수입니다. 해당 함수의 재진입 취약성을 개선하세요.

*/

contract ReEntrancy1 {

    mapping (address => uint) private userBalances;
    mapping (address => bool) private claimedBonus;
    mapping (address => uint) private rewardsForA;

    function withdrawReward(address recipient) public {
        uint amountToWithdraw = rewardsForA[recipient];
        rewardsForA[recipient] = 0;
        (bool success, ) = recipient.call{value : amountToWithdraw}("");
        require(success);
    }

    // 취약한 함수
    function getFirstWithdrawalBonus(address recipient) public {
        require(!claimedBonus[recipient]); // Bonus는 address당 단 한번만 수령할 수 있습니다. 과연 그럴까요?

        rewardsForA[recipient] += 100;
        withdrawReward(recipient);
        claimedBonus[recipient] = true;
    }

}