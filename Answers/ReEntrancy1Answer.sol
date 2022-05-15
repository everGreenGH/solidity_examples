// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract ReEntrancy1 {

    mapping (address => uint) private userBalances;
    mapping (address => bool) private claimedBonus;
    mapping (address => uint) private rewardsForA;

    // 신뢰할 수 없는 함수임을 함수명에 표기
    function untrustedWithdrawReward(address recipient) public {
        uint amountToWithdraw = rewardsForA[recipient];
        rewardsForA[recipient] = 0;
        (bool success, ) = recipient.call{value : amountToWithdraw}("");
        require(success);
    }

    // 개선된 함수
    function getFirstWithdrawalBonus(address recipient) public {
        require(!claimedBonus[recipient]);
        rewardsForA[recipient] += 100;
        claimedBonus[recipient] = true; // 외부 함수를 호출하기 전에 claimedBonus를 true로 설정하여, 재진입을 방지합니다.

        untrustedWithdrawReward(recipient); 
    }

}