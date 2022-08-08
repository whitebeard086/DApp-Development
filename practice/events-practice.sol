// Event example
// Abstraction - Decentralized Exchange: On a smart contract, traders can trade on the exchange.
// from the smart contract, emit an event so they can get the trade data.

// After the event is emitted, you can't read them in the past only for 
// entities outside the blockchain - not stored as memory.
// events have lower gas cost than storage.

pragma solidity >= 0.7.0 < 0.9.0;

contract LearnEvents {
    // declare an event for the contract
    // using camelCase for the event name is a good practice, something to remember
    // You are only allowed a maximum of 3 indexed parameters in an event, so choose wisely.
    event NewTrade(
        uint indexed date,
        address from,
        address indexed to,
        uint indexed amount
    );

    // declare a function that will emit the event
    function trade(address to, address from, uint amount) external {
        // emit the event
        // block.timestamp is a global variable that gets the current block timestamp
        emit NewTrade(block.timestamp, to, from, amount);
    }
}