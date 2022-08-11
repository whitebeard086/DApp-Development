// SPDX-License-Identifier: UNLICENSED

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
    mapping (address => mapping (address => uint256)) public allowance;

    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        // Check if the sender has enough balance
        require(balanceOf[msg.sender] >= _value);
        // Update the sender's balance after the transfer
        balanceOf[msg.sender] -= _value;
        // Update the receiver's balance after the transfer
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        // Check that the value is not greater than the sender's balance
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);
        // update the receiver's balance after the transfer
        balanceOf[_to] += _value;
        // update the sender's balance after the transfer
        balanceOf[_from] -= _value;
        // update the allowance of the sender for the receiver
        allowance[msg.sender][_from] -= _value;
        // emit the transfer event
        emit Transfer(_from, _to, _value);
        return true;
    }
}