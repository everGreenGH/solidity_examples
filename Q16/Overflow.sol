// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.4.18;

/*
    Q16. 안전하지 않은 산술 연산

    EVM은 타입에 따른 숫자 범위를 지정합니다(ex. uint8: 0-255). Q3에서 다루었듯이, 버전 0.8.0 미만의 Solidity에서는 overflow/underflow를 자체적으로 방지하지 않습니다.
    예를 들어, uint8로 정의한 변수에 256을 저장하려고 하면 overflow가 발생하여 0을 저장하게 됩니다.
    Overflow/underflow 취약점은 단순하지만, 자주 발생하는 보안 취약점입니다. 실제 많은 프로젝트들이 해당 취약점을 악용한 해킹의 피해를 입었습니다.
    Safemath를 활용하지 않는다면 항상 overflow/underflow 취약점이 발생하지 않는지 검토해야 합니다. 아래의 코드의 취약점을 개선해 보세요.
*/    

contract Token {

  mapping(address => uint) balances;
  uint public totalSupply;

  function Token(uint _initialSupply) {
    balances[msg.sender] = totalSupply = _initialSupply;
  }

  function transfer(address _to, uint _value) public returns (bool) {
    require(balances[msg.sender] - _value >= 0);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }

  function balanceOf(address _owner) public constant returns (uint balance) {
    return balances[_owner];
  }
}