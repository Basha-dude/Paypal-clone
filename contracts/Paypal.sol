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
    mapping (address => userName) names;

    constructor() {
        owner = msg.sender;
    }

    function addName(string memory _name) public {
       userName storage newuserName = names[msg.sender];
       newuserName.name = _name;
       newuserName.hasName = true;
    }

    function createRequest(address user, uint256 _amount, string memory _message) public {
         
          request memory newRequest;
          newRequest.requestor = user;
          newRequest.amount = _amount;
          newRequest.message = _message;
          if (names[msg.sender].hasName) {
             newRequest.name = names[msg.sender].name;
          }
          requests[user].push(newRequest);
            }

    function payRequest( uint256 _request)  public payable {

        require(_request < requests[msg.sender].length,"No such Request");
        request[] storage myRequests = requests[msg.sender];
        request storage payableRequest = myRequests[_request];

          uint256 toPay = payableRequest.amount * 1000000000000000000;
          require(msg.value == (toPay),"Pay correct amount");
          payable(payableRequest.requestor).transfer(msg.value);
          myRequests[_request] = myRequests[myRequests.length-1];
          myRequests.pop();

  }


  
}
