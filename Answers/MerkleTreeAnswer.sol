// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract MerkleTree {

    function verifier(
        bytes32[] memory proof, 
        bytes32 root, 
        bytes32 leaf, 
        uint8 index
    ) public pure returns(bool) {
        
        bytes32 hash = leaf;

        for (uint8 i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];

            if (index % 2 == 0) {
                hash = keccak256(abi.encodePacked(hash, proofElement));
            } else {
                hash = keccak256(abi.encodePacked(proofElement, hash));
            }

            index = index / 2;
        }

        if(hash == root) return true;
        else return false;
    }

}

/* 테스트 데이터

    3번째 leaf(index: 2)
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
