// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

/*
    Q11. 올바른 Call 함수의 사용

    .transfer()는 .send()의 재진입 공격 취약성을 해결하기 위하여 가스비 한도를 제한하는 방법을 사용하였지만, 2019년 이후 가스비의 상승으로 인하여 정상적인 트랜잭션을
    거부하는 문제점이 발생할 가능성이 발생합니다. 따라서 .send()와 .transfer() 대신 .call()을 사용하는 방법이 권장됩니다.
    단, .call()은 외부의 악의적 호출에 대하여 어떠한 보안 기능을 제공해주지 않기 때문에, 사용자 측면에서 보안 기능을 작성해야 합니다.
    .call(), .delegatecall()과 같은 low-level 메소드는 exception을 출력하지 않지만, 예외가 발생하였을 시 false를 반환합니다. 아래의 예시를 참고하세요.

    // 취약한 코드
    someAddress.send(55);
    someAddress.call{value: 55}(""); // 매우 위험: 재진입 공격에도 취약하고, 결과도 확인할 수 없기 때문

    // 개선된 코드
    (bool success, ) = someAddress.call{value: 55}("");
    if(!success) {
        // exception handling
    }

    외부에서의 .call() 함수의 호출은 실수로, 혹은 의도적으로 "실패"할 수 있습니다. 실패로 인한 피해를 줄이려면, 외부 호출을 호출자가 실행할 수 있는 별도의 트랜잭션으로
    분리하는 것이 올바른 .call() 함수의 작성법입니다. 즉, 컨트랙트가 자금을 외부 호출자에게 push하는 것보다, 외부 호출자가 스스로 자금을 인출(pull)하게 하는 것이 보다 안전합니다.
    
    지금까지 설명한 내용을 바탕으로 아래의 BetterCall 함수에서의 취약성을 개선해 보세요.
    1) call 함수의 실패 가능성에 대비하여 호출자의 address에 대한 자금 이동을 기록하는 refund 매핑을 작성하세요.
    2) 최고 입찰이 갱신될 때마다 higgestBidder에 대한 highestBid의 기록을 refund 매핑에 추가하세요.
    3) 최고 입찰자에게 ether를 송금하는 기능을 최고 입찰자가 실행할 수 있는 별도의 트랜잭션으로 분리하세요.

    (참고: .send()와 .transfer()의 차이와 재진입 공격)
    https://anomie7.tistory.com/56
*/

contract BetterCall {

    address highestBidder;
    uint highestBid;

    function bid() public payable {
        require(msg.value > highestBid);

        if (highestBidder != address(0)) {
            (bool success, ) = highestBidder.call{value: highestBid}("");
            require(success); // if this call consistently fails, no one else can bid
        }

       highestBidder = msg.sender;
       highestBid = msg.value;
    }
}