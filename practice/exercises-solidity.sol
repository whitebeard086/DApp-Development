// this is where our code goes

pragma solidity >=0.7.0 <0.9.0;

// Create a contract that can store data and return the data back

// Be able to do the following

// 1. Receive information, 2. Store information and 3. Return the information back

// A smart contract in the sense of Solidity is a collection of code (its functions) and data (its state) that resides at a specific address on the Ethereum blockchain.

contract simpleStorage {
    // write all the code inside here - functions and its state

    // Receive information
    uint storeData;

    // Store information
    // "public" keyword enables visibility, so that the function can be called outside of the contract itself, while the "private" keyword does the opposite
    function set(uint x) public {
        storeData = x;
    }

    // Retreive the information
    // "view" is a global modifier that tells the function that it can't modify state
    function get() public view returns (uint) {
        return storeData;
    }
}