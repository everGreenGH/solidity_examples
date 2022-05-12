// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract GasSaving {

    uint public total;

    function sumIfEvenAndLessThan99(uint[] memory nums) external {
        for (uint i = 0; i < nums.length; i++) {
            bool isEven = nums[i] % 2 == 0;
            bool isLessThan99 = nums[i] < 99;
            
            if (isEven && isLessThan99) {
                total += nums[i];
            }
        }
    }

    function sumIfEvenAndLessThan99_2(uint[] calldata nums) external {        
        uint _total = total;
        uint len = nums.length;

        for (uint i = 0; i < len; ++i) {
            uint num = nums[i];
            if (num % 2 == 0 && num < 99) {
                _total += num;
            }
        }

        total = _total;
    }
}