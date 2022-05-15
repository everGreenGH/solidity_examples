// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract BetterCallAnswer {

    address highestBidder;
    uint highestBid;

    mapping (address => uint) refunds;
    
    function withdrawRefund() external {
        uint refund = refunds[msg.sender];
        refunds[msg.sender] = 0; // 재진입 취약성 방지: Q13에서 다루게 됩니다.

        (bool success, ) = highestBidder.call{value: refund}("");
        require(success);
    }

    function bid() payable external {
        require(msg.value > highestBid);

        highestBidder = msg.sender;
        highestBid = msg.value;

        if (highestBidder != address(0)) {
            refunds[highestBidder] += highestBid;
        }
    }
}