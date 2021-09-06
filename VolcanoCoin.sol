// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract VolcanoCoin {
    uint supply = 10000;
    
    address owner;
    
    event SupplySet(uint);
    event TransferSet(uint, address);
    
    mapping(address => uint) public balances;
    mapping(address => Payments[]) payments;
    
    struct Payments {
        address addr;
        uint amount;
    }
    
    modifier onlyOwner(){
        if(msg.sender==owner){
            _;
        }
    }
    
    constructor(){
        owner = msg.sender;
        balances[owner] = supply;
        
    }
    
    
    function getSupply(uint) public view returns(uint){
        return supply;
    }
    
    function addSupply() public onlyOwner {
        supply = supply + 1000;
        emit SupplySet(supply);
    }
    
    function getBalance(address user) public view returns(uint){
        return balances[user];
    }
    
    function transferBalance(uint _amount, address _recipient) public  {
        if(getBalance(msg.sender) >= _amount)
        {
            balances[msg.sender] -= _amount;
            balances[_recipient] += _amount;
            emit TransferSet(_amount, _recipient);
            Payments memory currentPayment; 
            currentPayment.addr = _recipient;
            currentPayment.amount = _amount;
            payments[msg.sender].push(currentPayment);
        }
    }
    
    function getPayment(address _user) public view returns (Payments[] memory) {
        return payments[_user];
    }
    
}
