// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
 A deCentralized voting project for Community to vote their favourite project and chance to earn $VOTE
*/
contract projectVotes {
    address admin;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin () {
        require(msg.sender == admin,"You're not admin");
        _;
    }
    enum ProjectCategory  {DeFi,NFT,nftMarketplace,deSocial,InfraStructure,MEME,Bridges,DAO,Metaverse,Gaming}

    uint nextProjectId = 1;
    struct Project {
        uint projectId;
        string projectName;
        ProjectCategory projectCategory;
        uint voteCount;
        bool votedOnce;
    }

    // Mapping to store projects
    mapping(uint => Project) public projectDetails;
    
    function addProject(
        string memory _name,
        ProjectCategory _projectCategory
        ) 
        public onlyAdmin {
        projectDetails[nextProjectId]= Project 
        ({
          projectName : _name,
          projectCategory : _projectCategory,
          projectId : nextProjectId,
          voteCount : 0,
          votedOnce : false
         });

         nextProjectId++;
    }

    struct votingCampaign {
        ProjectCategory projectCategory;
        string campaignName;
        uint startTime;
        uint endTime;
        bool isLive;
    }

    mapping (ProjectCategory => votingCampaign) votingCampaigns;

    function startVotingCampaign (
        ProjectCategory _projectCategory,
        string memory _campaignName,
        uint _startTime,
        uint _endTime
    ) public onlyAdmin{
        require(block.timestamp <= _startTime && block.timestamp <= _endTime,"Current time should be less than Start time and/or end time.");
        votingCampaigns[_projectCategory] = votingCampaign (
            {
             projectCategory : _projectCategory,
              campaignName : _campaignName,
              startTime : _startTime,
              endTime : _endTime,
              isLive : true
            }
        );
    }

    // mapping to store address vote to project
    mapping (address => Project) public votes;
    function castVote (
     uint _projectId
    ) 
    public {
        votes[msg.sender] = Project (
            {
          projectName :projectDetails[_projectId].projectName,
          projectCategory : projectDetails[_projectId].projectCategory,
          projectId : projectDetails[_projectId],
          voteCount : 0,
          votedOnce : false
            }
        );
    }
}