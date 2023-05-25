// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Paypal {

 address public owner;
    
    struct request {
        address requestor;
        uint256 amount ;
        string message;
        string name;
        
    }
    struct SendReceive {
        string action;
        uint256 amount ;
        string message;
         address otherPartyName;
          string otherpartyname;
    }

    struct userName {
         string name;
         bool hasName;
        
    }

    mapping (address => request[]) requests;
    mapping (address => SendReceive[]) history;
    mapping (address => userName) userNames;

    constructor() {
        owner = msg.sender;
    }

    function createRequest(address _requestor, uint256 _amount, string memory _message, string memory _name) public {
         
         requests[msg.sender] =  request( _requestor,_amount,_message, _name);
  }


  
}
