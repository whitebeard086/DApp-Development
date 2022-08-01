pragma solidity ^0.8.7;

// The contract allows only its creator to create new coins (diffecrent issuance schemes are possible)
// Anyone can send coins to each other without the need to register with a username and password, all you need is an Ethereum keypair
contract Coin {
    // the keyword "public" makes variables declared here accessible from other contracts
    address public minter;
    mapping(address => uint) public balances;
}