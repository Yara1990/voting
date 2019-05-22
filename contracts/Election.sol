pragma solidity ^0.5.0;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;

    mapping(uint => Candidate) public candidates; 
    uint public candidatesCount;

    event votedEvent (
        uint indexed _candidateId
    );

    constructor() public {
        addCandidate("Modi");
        addCandidate("Rahul");
    }

    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0); // instantiate Candidate Object
    }


    function vote(uint _candidateId) public { 
        // Require the voter has not voted before
        require(!voters[msg.sender], "This address have voted");

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Candidate is not valid");

        // record that voter has voted.
        // rule: keeping track an account has voted (only once)
        voters[msg.sender] = true; 

        // Update candidate vote count
        candidates[_candidateId].voteCount++;

        // trigget voted event
        emit votedEvent(_candidateId);
    }
}