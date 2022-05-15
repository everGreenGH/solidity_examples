// SPDX-License-Identifier: MIT

/*
    Q11. Fallback과 Receive 함수

    Fallback 함수는 이름이 없는 무기명 함수입니다. Fallback 함수는 solidity 버전에 따라서 수행하는 기능이 다릅니다.

    Solidity 0.6.0 이전에서는 1) 스마트 컨트랙트가 Ether를 받을 수 있는 역할을 수행하였으며, 2) Ether를 받고 난 후 행동을 취하게 할 수 있으며, 
    3) 컨트랙트에 정의되지 않은 함수가 call을 통하여 불려질 때 호출되는 역할을 합니다.
    Fallback 함수의 문법은 아래와 같습니다.

    function() external payable { } // external, payable 키워드를 반드시 사용하여야 합니다.

    Solidity 0.6.0 이후에서는 receive 함수가 기존 fallback 함수의 일부 기능을 사용합니다: 1) 스마트 컨트랙트가 Ether를 받을 수 있는 역할을 수행합니다.
    Fallback 함수는 기존 fallback 함수의 (2), (3)번 기능을 수행합니다. 문법은 아래와 같습니다.
    
    function() external { } // payable을 작성하지 않을 시, 스마트 컨트랙트에 불려진 함수가 없을 경우 호출하는 역할을 하며, 
    function() external payable { } // payable 작성 시 ether를 받고 난 후의 행동을 추가하는 기능으로 활용할 수도 있습니다.
    receive() external payable { }

    Klaytn에서는 Solidity 0.6.0 이전 버전을 사용하기 때문에, 두 가지 문법 모두를 알아두는 것이 좋습니다.
    
    Remix IDE에서 컴파일러 버전을 0.5.17로 설정하고 컴파일한 후, Bank 컨트랙트와 Fallback 컨트랙트를 배포하세요. 
    1) Fallback 컨트랙트에서 depositWithSend/Transfer/Call 함수를 이용해 1 Ether를 송금해 보세요. 이벤트 출력을 확인하세요. 
       msg.sender의 값을 확인하세요. Fallback 컨트랙트가 Bank 컨트랙트의 함수를 호출한 것이기 때문에, msg.sender의 값은 fallback 컨트랙트의 주소가 됩니다.
    2) giveMessage, giveMessageWithFunds 함수도 실행해 보세요.
    3) 0.6.0~ 이후의 문법은 주석으로 처리되어 있습니다. 기존의 코드를 주석 처리한 후 주석 처리된 코드를 해제하고, 컴파일러 버전 0.8.11로 설정하여 위의 과정을 다시 반복하세요.
*/

pragma solidity ^0.5.17;
// pragma solidity ^0.8.11;

contract Bank {

    event FallbackWithFunds(address _from, uint256 _value, string message);
    event Fallback(address _from, string message);
    event ReceiveFallback(address _from, uint256 _value, string message);

    // Solidity 버전 ~0.6.0
    function() external payable {
        emit FallbackWithFunds(msg.sender, msg.value, "Event FallbackWithFunds is called.");
    }

    // Solidity 버전 0.6.0~

    // fallback() external {
    //     emit Fallback(msg.sender, "Event Fallback is called.");
    // }

    // receive() external {
    //     emit ReceiveFallback(msg.sender, msg.value, "Event ReceiveFallback is called.");
    // }
}

contract Fallback {

    function depositWithSend(address payable _to) public payable {
        bool success = _to.send(msg.value);
        require(success, "Failed");
    }

    function depositWithTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function depositWithCall(address payable _to) public payable {
        (bool sent, ) = to.call.value(msg.value)("");
        // (bool sent, ) = _to.call{value : msg.value}("");
        require(sent, "Failed to send ether");
    }

    function giveMessage(address _to) public {
        (bool success, ) = _to.call("HI"); // "HI"라는 함수가 없다면 fallback 함수가 실행됩니다.
        // (bool success, ) = _to.call("HI");
        require(success, "Failed to call function");
    }

    function giveMessageWithFunds(address payable _to) public payable {
        (bool sent, ) = _to.call.value(msg.value)("HI");
        // (bool sent, ) = _to.call{value: msg.value}("HI");
        require(sent, "Failed to send ether");
    }

}