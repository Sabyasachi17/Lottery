pragma solidity ^0.4.17;

contract Lottery
{
    address public manager;
    address[] public players;
    uint256 index;
    
    function Lottery() public
    {
        manager=msg.sender;
        
    }
    function enter() public payable
    {
        require(msg.value > 0.01 ether);        
        
        players.push(msg.sender);
        
    }
    function total_players() public view returns(uint256)
    {
        return (players.length-1);
    }
    function amount() public view returns(uint256)
    {
        return this.balance;
    }
    function random() public view returns(uint256)
    {
     uint256 k= uint256(keccak256(block.difficulty, now , players));
     return uint256(k);
     
    }
    function pickWinner() public restricted {
        uint k=random();
        index = k % players.length;
        players[index].transfer(this.balance);
        players = new address[](0);
    }
    function winner() public view returns(address)
    {
        return players[index];
        
    }
    modifier restricted()
    {
     require(msg.sender==manager);   
     _;
    }
    function getPlayers() public view returns(address[])
    {
        return players;
    }
}
    
    
    
    
