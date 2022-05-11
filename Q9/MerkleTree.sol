// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

/*

    Q9: 머클 트리(Merkle Tree) 구현하기

    머클 트리는 블록에서 거래을 빠르게 찾아줄 수 있으며, 거래의 위/변조 여부를 확인할 수 있기 때문에 블록체인에서 매우 중요한 개념입니다.
    마스터링 비트코인에서 배웠던 머클 트리의 개념이 기억나지 않는다면, 아래의 링크를 참고해서 리마인드할 수 있기를 바랍니다.

    MerkleProof 컨트랙트의 verifier 함수는 블록에서 주어진 트랜잭션이 존재하는지 확인하여, 그 값을 true 또는 false로 반환합니다.
    verifier 함수를 구현하고, 컨트랙트를 배포한 후 verifier 함수를 실행하여 그 결과를 확인하세요. 테스트 데이터는 아래에 주석으로 주어집니다.

    (참고: 머클 트리란?)
    https://www.banksalad.com/contents/%EC%89%BD%EA%B2%8C-%EC%84%A4%EB%AA%85%ED%95%98%EB%8A%94-%EB%B8%94%EB%A1%9D%EC%B2%B4%EC%9D%B8-%EB%A8%B8%ED%81%B4%ED%8A%B8%EB%A6%AC-Merkle-Trees-%EB%9E%80-ilULl

*/

contract MerkleTree {

    /*
        verifer 함수는 검증하고자 하는 거래와 해당 거래의 index, 머클 루트와 경로상에 있는 거래의 집합을 입력값으로 받습니다.
        경로상에 있는 거래의 집합에 대해서 예를 들자면, 머클 트리에 8개의 거래가 있고 5번째 거래를 검증할 경우, 거래 6, 거래 7+8, 거래 1+2+3+4가 집합을 구성합니다.
        2개의 입력값에 대한 해시값을 구하는 방법은 hash = keccak256(abi.encodePacked(입력값1, 입력값2)); 입니다. 입력값의 순서가 바뀔 경우 해시값도 달라짐에 유의하세요.
    */

    function verifier(
        bytes32[] memory proof, 
        bytes32 root, 
        bytes32 leaf, 
        uint8 index
    ) public pure returns(bool) {
        
        bytes32 hash = leaf;

        // 여기에 코드를 작성하세요.

    }
}

/* 테스트 데이터

    3번째 leaf(array는 0부터 시작하므로 index는 2가 됩니다.)
    0xdca3326ad7e8121bf9cf9c12333e6b2271abe823ec9edfe42f813b1e768fa57b

    루트
    0xcc086fcc038189b4641db2cc4f1de3bb132aefbd65d510d817591550937818c7

    Index
    2

    Proof
    ["0x8da9e1c820f9dbd1589fd6585872bc1063588625729e7ab0797cfc63a00bd950", "0x995788ffc103b987ad50f5e5707fd094419eb12d9552cc423bd0cd86a3861433"]
    (3번째 거래에 대한 검증이므로 4번째 거래, 1+2번째 거래가 됩니다.)

    올바른 verifier 함수를 설계하였을 시, 해당 값에 대하여 true를 출력해야 합니다.
    
*/
