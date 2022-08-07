pragma solidity ^0.8.0;

contract Tether {
    string public name = "Mock Tether";
    string public symbol = "mUSDT";
    uint8 public decimals = 18;
    uint256 public totalSupply = 10000000000000000000000; // 1 million tokens 

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint _value
    );

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint _value
    );

    mapping (address => uint256) public balanceOf;

    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint _value) public returns (bool success) {
        // Check if the sender has enough balance
        require(balanceOf[msg.sender] >= _value);
        // Update the sender's balance after the transfer
        balanceOf[msg.sender] -= _value;
        // Update the receiver's balance after the transfer
        balanceOf[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}