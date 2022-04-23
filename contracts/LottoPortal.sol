// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract LottoPortal {
    uint256 constant ticketPrice = 0.001 ether;

    uint256 private seed;

    Ticket[] tickets;
    uint256 pool;

    struct Ticket {
        address payable owner;
        uint256 number;
    }

    constructor() {
        console.log("Lotto system constructed!");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function buyTicket(uint256 _number) public payable {
        require(msg.value >= ticketPrice, "You must pay 0.001 ETH for the lottery ticket.");
        pool += ticketPrice;
        tickets.push(Ticket(payable(msg.sender), _number));
    }

    function getPool() public view returns (uint256) {
        return pool;
    }

    function getAllTickets() public view returns (Ticket[] memory) {
        return tickets;
    }

    function getTickets(address _owner) public view returns (Ticket[] memory) {
        uint count = 0;
        for (uint i = 0; i < tickets.length; i++) {
            if (tickets[0].owner == _owner) {
                count++;
            }
        }

        Ticket[] memory result = new Ticket[](count);
        uint j = 0;
        for (uint i = 0; i < tickets.length; i++) {
            if (tickets[0].owner == _owner) {
                result[j++] = tickets[i];
            }
        }
        return result;
    }

    function draw() public {
        // draw a new number
        seed = (block.difficulty + block.timestamp + seed) % 100;

        if (tickets.length == 0) {
            return;
        }

        // chose the ticket which was the closest to the seed
        Ticket memory closest = tickets[0];
        for (uint i = 0; i < tickets.length; i++) {
            if (abs(int(tickets[i].number) - int(seed)) < abs(int(closest.number) - int(seed))) {
                closest = tickets[i];
            }
        }

        // transfer ETH
        closest.owner.transfer(address(this).balance);

        // clean current tickets
        delete tickets;
    }

    function abs(int _val) pure private returns(uint) {
        if (_val >= 0) {
            return uint(_val);
        }
        return uint(-_val);
    }

}