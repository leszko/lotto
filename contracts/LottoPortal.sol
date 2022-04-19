// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract LottoPortal {
    uint256 constant ticketPrice = 0.001 ether;

    uint256 private seed;

    Ticket[] tickets;
    uint256 pool;

    struct Ticket {
        address owmer;
        uint256 number;
    }

    constructor() {
        console.log("Lotto system constructed!");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function buyTicket(uint256 _number) public payable {
        require(msg.value >= ticketPrice, "You must pay 0.001 ETH for the lottery ticket.");
        pool += ticketPrice;
        tickets.push(Ticket(msg.sender, _number));
    }

    function getPool() public view returns (uint256) {
        return pool;
    }

    function getTickets() public view returns (Ticket[] memory) {
        return tickets;
    }
}