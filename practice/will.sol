pragma solidity ^0.8.1;

contract will {
    address owner;
    uint fortune;
    bool deceased;

    constructor() payable public {
        owner = msg.sender; // msg.sender represents address that is being called
        fortune = msg.value; // msg.value tells us how much is being sent
        deceased = false;
    }
}