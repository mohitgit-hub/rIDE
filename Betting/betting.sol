// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract BettingDapp {

    address admin;
    uint nextCampaignId = 1;
    uint nextUserId = 1;

    //Makes deployer admin
    constructor () {
        admin = msg.sender;
    }

    // onlyAdmin modifier
    modifier onlyAdmin () {
        require(msg.sender == admin);
        _;
    }


    enum campaignStatus {notLive,Live,Completed,Stopped}
    enum category {Sport,Education,Politics,Crypto,Creators,Business}
    
    mapping (uint=> bettingCampaign) bettingCampaigns;  // Mapping to store Batting Campaigns
    mapping (uint=>userBetting) userBettings;           //Mapping to store info of user battings in campaigns
    
    struct bettingCampaign {
        uint bettingCampaignId;
        string campaignTittle;
        uint category;
        uint minUser;
        uint minAmount;
        uint maxAmount;
        uint startTime;
        uint endTime;
        bool isStart;
        uint totalUser;
    }

    struct userBetting {
        uint userId;
        address user;
        uint bettingFor;
        uint userAmount;
        bool isWin;
        uint totalBettingCampaigns;
        uint totalWins;
        uint totalLoss;
        uint userBalance;
        bool prevBetting;
    }

    function createCampaign (string memory _campaignTittle,uint _category,uint _minUser,uint _minAmount, uint _maxAmount, uint _startTime, uint _endTime ) public onlyAdmin {
        //admin require error
        bettingCampaigns[nextCampaignId] = bettingCampaign 
            (
                {
                     bettingCampaignId : nextCampaignId,
                     campaignTittle : _campaignTittle,
                     category : _category,
                     minUser : _minUser,
                     minAmount : _minAmount,
                     maxAmount : _maxAmount,
                     startTime : _startTime,
                     endTime : _endTime,
                     totalUser : 0,
                     isStart : false
                }
            );
            nextCampaignId++;
    }

    //Function to start campaign
    function startCampaign (uint _campaignId) public onlyAdmin {
            require(block.timestamp <= bettingCampaigns[_campaignId].startTime-7200,"You cannot start 2 hours before");
            require(block.timestamp >= bettingCampaigns[_campaignId].endTime,"You cannot start because campaign time already ended");
            bettingCampaigns[nextCampaignId].isStart = true; 
    }

    function emergencyStopCampaign (uint _campaignId) public onlyAdmin{
        require(block.timestamp >= bettingCampaigns[_campaignId].startTime && block.timestamp <= bettingCampaigns[_campaignId].endTime,"Voting is already closed");
        bettingCampaigns[nextCampaignId].isStart = false; 
    }

    function emergencyResumeCampaign (uint _campaignId) public onlyAdmin{
        require(block.timestamp >= bettingCampaigns[_campaignId].startTime && block.timestamp <= bettingCampaigns[_campaignId].endTime,"Voting is already closed");
        bettingCampaigns[nextCampaignId].isStart = true; 
    }

    function placeBet (uint _campaignId) public payable{
        require(bettingCampaigns[nextCampaignId].isStart,"Campaign not started yet");
        require(bettingCampaigns[_campaignId].totalUser >= bettingCampaigns[_campaignId].minUser);
        require(bettingCampaigns[nextCampaignId].isStart == true,"");
        payable(address(this)).transfer(msg.value);   // Transfer user fund to contract for campaign
        userBettings[_campaignId].userId = nextUserId;
        nextUserId++; 
        userBettings[_campaignId].user = msg.sender; // Transfer user address in userBettings[_campaignId].user
        userBettings[_campaignId].bettingFor = _campaignId;  // // Transfer campaignId in userBettings[_campaignId].bettingFor  
        userBettings[_campaignId].userAmount = msg.value;
        userBettings[_campaignId].isWin = false;
        userBettings[_campaignId].isWin = false;


    }

    function deleteCampaign (uint _campaignId) public onlyAdmin{
        
    }

    function showCampaigns () public view returns (bettingCampaign [] memory) {
        
    }
    

    function showCompletedCampaign ( ) public {
        
    }

    function showCampaignInProgress () public {
        
    }

    function showCancelledCampaign () public {
        
    }

    function joinCampaign (uint _campaignId) public {
        bettingCampaigns[_campaignId].totalUser++;
    }
    

    function withdrawBalance (uint _campaignId,uint _value) public payable{
        
    }


}