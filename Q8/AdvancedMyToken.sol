// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract AdvancedMyToken {

    /*
        Q8: 나만의 Token 발전시키기

        Q6에서 제작한 MyToken 컨트랙트에 approve, transferFrom 함수를 구현하세요.
        approve 함수와 transferFrom 함수는 크립토좀비에서 사용하였던 approve와 takeOwnership 함수와 기능적으로 동일합니다. 
        일반적으로 스마트 컨트랙트에서는 transfer보다 approve와 transferFrom 함수를 주로 사용합니다. 아래의 링크를 참고하세요.

        (참고)
        https://ethereum.stackexchange.com/questions/46457/send-tokens-using-approve-and-transferfrom-vs-only-transfer
    */

    /*
        아래에 Q6에서 작성한 컨트랙트 내부를 가져오세요. 
        거래의 승인을 관리하는 매핑 allowance를 추가하세요. 매핑 allowance는 아래에 작성되어 있습니다.
        매핑의 중첩이라는 개념은 생소하게 느껴질 수도 있을 텐데요, allowance의 경우 address 두 개(보내는 사람, 받는 사람)를 입력받았을 때 
        해당하는 금액이 매핑되어 있는 것으로 생각하시면 이해가 편할 것 같습니다.
    */

    // 여기에 코드를 붙여넣으세요.

    mapping(address => mapping(address => uint256)) public allowance;





    // 아래부터는 Q8에서 구현할 함수입니다.

    function approve(address _spender, uint256 _value) public returns (bool) {
        
        // 여기에 코드를 작성하세요.

    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool) {
        
        // 여기에 코드를 작성하세요.
        
    }
}