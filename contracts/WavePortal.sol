// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;
    
    event NewWave(address indexed from, uint timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint timestamp;
    }

    Wave[] waves; // Hold all the wave structs that people send!

    constructor() payable {
        console.log("Constructed");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s saved with message %s", msg.sender, _message);
        waves.push(Wave(msg.sender, _message, block.timestamp));
        emit NewWave(msg.sender, block.timestamp, _message);

        uint prizeAmount = 0.0001 ether;
        require(prizeAmount <= address(this).balance, "Trying to withdraw more money than c ontract has.");
        (bool success,) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract");
    }

    function getAllWaves() view public returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() view public returns (uint) {
        console.log("We have %d total waves", totalWaves);
        return totalWaves;
    }
}
