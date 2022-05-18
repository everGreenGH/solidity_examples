// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

/*
    Q17: 예상하지 못한 컨트랙트로의 강제 Ether 전송

    Solidity에서 많은 개발자들이 오해하고 있는 것은 payable 키워드를 통해서만 이더의 전송 또는 수령이 가능할 것이라는 생각입니다: 그러나 이는 보안 취약점을 만들 수 있습니다.
    공격자는 어떠한 계정이든(사용자의 계정 또는 컨트랙트 계정) 강제로 이더를 전송할 수 있으며, 아래 두 가지의 경우에서는 fallback 함수를 발동시키지 않습니다.
    1) selfdestruct(target): selfdestruct 함수는 컨트랙트 주소에서 모든 bytecode를 제거하며, 남은 Ether를 모두 target의 주소로 전송합니다.
       이 때 target은 컨트랙트가 될 수도 있는데, 이 경우 해당 컨트랙트의 코드와 무관하게(payable 함수가 없더라도) Ether를 강제로 보낼 수 있습니다. 
    2) Pre-sent Ether: 해시 함수는 결정론적(deterministic) 함수입니다. 컨트랙트 주소는 컨트랙트를 생성하는 사람의 주소와 transaction nonce를 통하여 계산되는데,
       이를 통해 공격자는 컨트랙트가 생성되기 전에 컨트랙트의 주소를 계산하여, 해당 주소로 Ether를 미리 보낼 수 있습니다. 
       이 경우 컨트랙트가 생성되었을 시 Ether의 잔액이 0이 아니게 됩니다.
    즉, 컨트랙트에 저장된 Ether의 잔고는 외부 사용자가 변경할 수 있으며, 해당 사실을 인지하고 컨트랙트를 작성하여야 합니다.
    위의 사항을 고려하여 아래 컨트랙트에서 발생할 수 있는 취약점을 개선해 보세요.
*/    

contract EtherGame {

    uint public payoutMileStone1 = 3 ether;
    uint public mileStone1Reward = 2 ether;
    uint public payoutMileStone2 = 5 ether;
    uint public mileStone2Reward = 3 ether;
    uint public finalMileStone = 10 ether;
    uint public finalReward = 5 ether;

    mapping(address => uint) redeemableEther;

    // 플레이어들은 0.5 Ether를 지불하고, 마일스톤을 달성할 때마다 해당 플레이어는 정해진 Ether를 얻습니다.
    function play() external payable {
        
        require(msg.value == 0.5 ether);
        uint currentBalance = address(this).balance + msg.value;

        // 게임을 끝낸 플레이어의 접근을 제한합니다.
        require(currentBalance <= finalMileStone);
        
        // 마일스톤에 도달할 시, 플레이어에게 보상을 제공합니다.
        if (currentBalance == payoutMileStone1) {
            redeemableEther[msg.sender] += mileStone1Reward;
        }
        else if (currentBalance == payoutMileStone2) {
            redeemableEther[msg.sender] += mileStone2Reward;
        }
        else if (currentBalance == finalMileStone ) {
            redeemableEther[msg.sender] += finalReward;
        }
        return;
    }

    function claimReward() public {

        require(address(this).balance == finalMileStone);
        require(redeemableEther[msg.sender] > 0);

        uint transferValue = redeemableEther[msg.sender];
        redeemableEther[msg.sender] = 0;

        (bool success, ) = msg.sender.call{value : transferValue}("");
        require(success);
    }
 }