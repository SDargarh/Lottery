pragma solidity >=0.7.0 <0.9.0;
 
contract Lottery {
    
    address[] private players;
    address public manager;
    
    constructor() {
        manager = msg.sender;
    }
    
    function getPrize() public view returns (uint) {
         // .balance is the total eth sent to this contract. 
        return address(this).balance;
    }
    
    function getPlayers() public view returns (address[] memory) {
        return players; 
    }
    
    function enter() public payable {
        require(msg.value >= .01 ether, '402: below minimum wager.'); 
        players.push(msg.sender); 
    }
    
    function pickWinner() public onlyManager {
        // Index winner using uint from 0 to players.length -1.
        address winner = players[random() % players.length];
        // Use payable() to convert winner of type address 
        // to address payable in order to transfer balance. 
        payable(winner).transfer(address(this).balance); 
        // Empty players array. 
        delete players;
    }
    
    // Pseudo random number generator. 
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
        // E.g. 60817645111108788401576359622900687189766325208998821960496561789223450725174 
    }
    
    modifier onlyManager {
        require(msg.sender == manager, '403: call restricted to manager.');
        _;
    }
}