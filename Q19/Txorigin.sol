// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

/*
    Q19: Tx.origin 인증 취약성

    Tx.origin은 Solidity에서 제공하는 global variable로, Tx.origin은 전체 call stack을 순회하여 해당 call을 최초로 전송한 사용자의 주소를 반환합니다.
    이는 컨트랙트가 트랜잭션을 발생시킬 수 있기 때문으로, 원 트랜잭션을 발생시킨 주체를 반환할 필요성이 있는 상황에서 사용합니다.
    그러나 Tx.origin의 보안 취약성으로 인하여, 컨트랙트에서 해당 값을 이용하여 인증과 같은 작업을 하는 것은 위험합니다.
    예를 들어, 공격자는 피싱 공격을 통하여 취약한 컨트랙트의 승인이 필요한 함수를 실행시킬 수 있습니다. 아래의 예시를 통해 알아볼까요?
*/

contract Phishable {
    address public owner;

    constructor (address _owner) {
        owner = _owner;
    }

    receive () external payable {} // collect ether

    // tx.origin을 이용하여 관리자임을 인증하고, 출금하는 함수입니다.
    function withdrawAll(address payable _recipient) public {
        require(tx.origin == owner);
        _recipient.transfer(address(this).balance);
    }
}

/*
    만약 해당 컨트랙트를 공격하려는 해커가 일반 사용자로 위장하여, 위의 Phishable 컨트랙트를 배포한 사용자가 아래의 컨트랙트로 ether를 송금하였다고 가정합니다.
    이 때 해커의 컨트랙트의 fallback 함수가 실행되어, Phishable 컨트랙트의 withdrawAll 함수를 호출합니다.
    tx.origin은 트랜잭션을 발생시킨 사용자의 주소를 반환합니다. 즉, 이 상황에서는 Phishable 컨트랙트를 배포한 사용자의 주소가 tx.origin의 반환값이 됩니다.
    withdrawAll 함수는 해커의 주소로 모든 잔액을 출금합니다.
*/

// 공격자 컨트랙트

// pragma solidity ^0.8.11;

// import "Phishable.sol";

// contract AttackContract {

//     Phishable phishableContract;
//     address attacker; // 해커의 주소

//     constructor (Phishable _phishableContract, address _attackerAddress) {
//         phishableContract = _phishableContract;
//         attacker = _attackerAddress;
//     }

//     fallback () external payable {
//         phishableContract.withdrawAll(attacker);
//     }
// }

/*
    tx.origin을 인증 조건으로 사용하는 것은 매우 위험하며, 지양해야 합니다.
    단, 외부 컨트랙트가 본인의 컨트랙트를 호출할 수 없도록 require(tx.origin == msg.sender) 와 같이 한정적으로 사용할 수 있습니다.
*/