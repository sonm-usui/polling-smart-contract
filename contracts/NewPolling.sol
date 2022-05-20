pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract NewPolling {
    struct Voter {
        address voter;
        string name;
        bool voted;
    }

    string[] public selectedCandidates;

    struct Proposal {
        string name;
        uint voteCount;
    }

    mapping(address => Voter) public newVoters;

    Voter[] public voters;

    Proposal[] public proposals;

    address public chairperson;

    string public winner;

    constructor() public {
        chairperson = msg.sender;
        console.log('chairperson : ', chairperson);
    }

    function addCandidate(string memory name) public {
        proposals.push(Proposal({
        name : name,
        voteCount : 0
        }));
    }

    function vote(string memory name) public {
        Voter storage sender = newVoters[msg.sender];
        require(!sender.voted,
            "You have already voted.");

        voters.push(Voter({
        voter : msg.sender,
        name : name,
        voted : true
        }));

        for (uint i = 0; i < proposals.length; i++) {
            if (compare(proposals[i].name, name) == 0) {
                proposals[i].voteCount++;
            }
        }
    }

    function getVotersList() public view returns (Voter[] memory) {
        return voters;
    }

    function getProposalLists() public view returns (Proposal[] memory) {
        return proposals;
    }

    function winningProposal() public view returns (uint winningProposal_){
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
        return winningProposal_;
    }

    function winnerName() external view returns (string memory winnerName_){
        winnerName_ = proposals[winningProposal()].name;
    }


    function compare(string memory _a, string memory _b) public returns (int) {
        bytes memory a = bytes(_a);
        bytes memory b = bytes(_b);
        uint minLength = a.length;
        if (b.length < minLength) minLength = b.length;
        for (uint i = 0; i < minLength; i ++)
            if (a[i] < b[i])
                return - 1;
            else if (a[i] > b[i])
                return 1;
        if (a.length < b.length)
            return - 1;
        else if (a.length > b.length)
            return 1;
        else
            return 0;
    }
}
