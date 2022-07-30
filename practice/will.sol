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

    // Modifiers are add-ons for functions that can create additional logic for them

    // create modifier so the only person who can call the contract is the owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    // create modifier so that we can allocate funds if friend's gramps is deceased
    modifier grampsDeceased {
        require(deceased == true);
        _;
    }

    // initialize a payable empty array to store the list of wallet addresses of family members
    address payable[] familyWallets;

    // map through inheritance
    mapping(address => uint) inheritance;

    // set inheritance for each address
    function setInheritance(address payable wallet, uint amount) public {
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }
}