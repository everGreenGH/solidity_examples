// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract CPMMAnswer {

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
        
        // 거래 시 Liquidity Pool은 0.3%의 수수료를 수취합니다. 수수료는 유동성 풀과 무관하다고 가정합니다(수수료의 이동을 구현할 필요는 없습니다.).
        uint256 amountInWithFee = (_amountIn * 997) / 1000;
        
        /*
            간단한 수학적 계산을 해볼까요?
            token x를 token y로 swap하고자 하는 거래(dx -> dy)로 인하여 유동성 풀은 xy = k -> (x + dx)(y - dy) = k 로 변화합니다.
            우리가 구하고자 하는 값은 dy이므로, dy를 제외하고 우변으로 이동하여 정리해 봅시다.
            (y - dy) = k / (x + dx) 
            dy = y - (xy / (x + dx))
            dy = (xy + dx * y - xy) / (x + dx) = (dx * y) / (x + dx)
            이제 해당 식을 위에서 선언한 변수로 표현하면, 쉽게 amountOut에 대한 식을 구할 수 있습니다.
        */

        uint256 amountOut = (reserveOut * amountInWithFee) / (reserveIn + amountInWithFee);
        (uint256 newReserve0, uint256 newReserve1) = isToken0
            ? (reserveIn + _amountIn, reserveOut - amountOut)
            : (reserveOut - amountOut, reserveIn + _amountIn);

        _update(newReserve0, newReserve1);
        return (tokenOut, amountOut);
    }
}