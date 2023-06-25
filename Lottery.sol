// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract Lottery
{
    address public manager;
    address payable[] public participants;
    event Anoucement(address , string , uint);

    constructor(){
        manager = msg.sender;
    }

    receive() external payable {
        require(msg.value == 1 gwei);
        participants.push(payable(msg.sender));
    }

    function getBalance() public view returns (uint){
        require(msg.sender == manager);
        return address(this).balance;
    }


    function Random_Number() view public returns (uint){

        return uint(keccak256(abi.encodePacked(block.timestamp)));
    }

    function winner() public{

        require(msg.sender == manager);
        require(participants.length >= 2);
        uint index = Random_Number() % participants.length;
        address payable winner_address = participants[index];
        participants = new address payable[](0);
        emit Anoucement(winner_address," Wins ", getBalance());
        winner_address.transfer(getBalance());
    }


}