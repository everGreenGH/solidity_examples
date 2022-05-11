// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract CPMM {

    /*
        Q10. CPMM swap 구현하기
        
        CPMM(Constant Product Market Maker)는 탈중앙화된 거래소(DEX) 구현에서의 핵심 개념입니다.
        CPMM은 order book 없이 거래가 진행될 수 있도록 유동성 풀(liquidity pool)의 개념을 도입하였습니다.
        CPMM에서의 유동성 풀은 x * y = k(constant product)를 통하여 구현할 수 있습니다.
        CPMM에서의 swap을 구현해 봅시다.

        (참고: 유동성 풀과 CPMM 개념)
        https://sohwak.tistory.com/entry/defi-studying-1-about-liquidity
        https://sohwak.tistory.com/entry/defi-studying-2-how-amm-determine-the-price
    */

    string public token0 = "MyTokenA";
    string public token1 = "MyTokenB";

    uint256 public reserve0 = 50000000;
    uint256 public reserve1 = 200000000;

    // 유동성 풀에서의 token0과 token1의 reserve를 업데이트합니다.
    function _update(uint _reserve0, uint _reserve1) private {
        reserve0 = _reserve0;
        reserve1 = _reserve1;
    }

    // 문자열 비교 함수입니다.
    function _compareString(string memory a, string memory b) private pure returns (bool) {
        if(bytes(a).length != bytes(b).length) {
            return false;
        } else {
            return keccak256(bytes(a)) == keccak256(bytes(b));
        }
    }

    /*
        교환하고자 하는 Token과 교환하고자 하는 수량을 입력값으로 제공하였을 시, swap 이후 얻는 Token과 해당 Token의 수량을 반환하는 함수 swap을 구현하세요.
    */
    function swap(string memory _tokenIn, uint256 _amountIn) public returns (string memory, uint256) {
        
        // 입력한 token이 token0 또는 token1이 아닐 때, swap 트랜잭션이 실행되는 것을 방지합니다.
        require(
            _compareString(_tokenIn, token0) || _compareString(_tokenIn, token1),
            "Invalid token"
        );

        // token0을 token1로 swap할 경우는 isToken0이 true가 되고, 그 반대의 경우 false가 됩니다.
        bool isToken0 = _compareString(_tokenIn, token0);

        // swap하고자 하는 token이 무엇인지에 따라 reserve의 in, out변수에 값을 대입합니다.
        (string memory tokenOut, uint256 reserveIn, uint256 reserveOut) = isToken0
            ? (token1, reserve0, reserve1) 
            : (token0, reserve1, reserve0);
        
        // 거래 시 Liquidity Pool은 0.3%의 수수료를 수취합니다. 수수료는 유동성 풀과 무관하다고 가정합니다(수수료의 이동을 구현할 필요는 없습니다).
        uint256 amountInWithFee = (_amountIn * 997) / 1000;

        // 여기에 코드를 작성하세요.


    }
}