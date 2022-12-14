pragma solidity ^0.8.7;

// The contract allows only its creator to create new coins (diffecrent issuance schemes are possible)
// Anyone can send coins to each other without the need to register with a username and password, all you need is an Ethereum keypair
contract Coin {
    // the keyword "public" makes variables declared here accessible from other contracts
    address public minter;
    mapping(address => uint) public balances;

    event Sent(address from, address to, uint amount);

    // constructor functions only run when the contract is deployed
    constructor() {
        minter = msg.sender;
    }

    // make new coins and send them to an address
    // only the owner should be able to send these coins
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    // send any amount of coins to an existing address
    error insufficientBalance(uint requested, uint available);

    function send(address receiver, uint amount) public {
        if(amount > balances[msg.sender])
        revert insufficientBalance({
            requested: amount,
            available: balances[msg.sender]
        });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
    }
}