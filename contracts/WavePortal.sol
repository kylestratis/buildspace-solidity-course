// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;
    constructor () {
        console.log("yo yo I'm a contract and I'm smart");
    }

    function wave() public {
        totalWaves += 1;
        console.log("%s is waved!", msg.sender);
    }

    function getTotalWaves() view public returns (uint) {
        console.log("We have %d total waves", totalWaves);
        return totalWaves;
    }
}
