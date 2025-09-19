// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {Raffle} from "../../src/Raffle.sol";

contract RaffleGasTest is Test {
    Raffle public raffle;
    address PLAYER = address(1);

    function setUp() external {
        raffle = new Raffle(
            1, // subscriptionId (fake id)
            bytes32(uint256(0xabc)), // gasLane (dummy value)
            30, // interval
            0.01 ether, // entranceFee
            uint32(500000), // callbackGasLimit
            address(0x123) // dummy VRF Coordinator
        );

        vm.deal(PLAYER, 10 ether);
    }

    function testGas_enterRaffle() public {
        vm.prank(PLAYER);
        raffle.enterRaffle{value: 0.01 ether}();
    }

    function testGas_getEntranceFee() public view {
        raffle.getEntranceFee();
    }

    function testGas_getNumberOfPlayers() public view {
        raffle.getNumberOfPlayers();
    }

    function testGas_getRecentWinner() public view {
        raffle.getRecentWinner();
    }

    function testGas_getRaffleState() public view {
        raffle.getRaffleState();
    }
}
