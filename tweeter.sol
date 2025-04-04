//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract Tweeter {

    struct Tweet {
        uint id;
        address author;
        string content;
        uint createdAt;
    }

    struct Message {
        uint id;
        address from;
        address to;
        string content;
        uint createdAt;
    }

    mapping (uint=>Tweet) public tweets;        // Information about tweets
    mapping (address=>uint[]) public tweetsOf; //mapping to store tweet IDs
    mapping (address=>Message[]) public conversations; // mapping to store information about messages
    mapping (address=>mapping (address=>bool)) public operators; //mapping for operators
    mapping (address=>address[]) public following;  //mapping to store detail about followed accounts

    uint nextId;
    uint nextMessageId;

    function _tweet(address _from, string memory _content) internal {
        tweets[nextId]= Tweet(nextId, _from,_content,block.timestamp);
        tweetsOf[_from].push(nextId);
        nextId=nextId+1;
    }

    function _sendMessage(address _from, address _to, string memory _content) internal {
        conversations[_from].push( Message(nextMessageId, _from,_to,_content,block.timestamp));
        nextMessageId=nextMessageId+1;
    }

    function tweet(string memory _content) public {  //Tweet from user
        _tweet(msg.sender, _content);
    }
    function tweet(address _from, string memory _content) public { //Tweet from operator
        require(operators[_from][msg.sender]==true,"You're not an operator");
        _tweet(_from, _content);
    }

    function sendMessage(address _to,string memory _content) public {  //sendMessage from user
        _sendMessage(msg.sender,_to,_content);
    }
    function sendMessage(address _from,address _to,string memory _content) public { //sendMessage from operator
            require(operators[_from][msg.sender]==true,"You're not an operator");
            _sendMessage(_from,_to,_content);
    }

    function follow(address _followed) public {
        following[msg.sender].push(_followed); //function to store information of followed accounts
    }

    function allow(address _operator) public {
        
        operators[msg.sender][_operator]=true;      
    }
    function disAllow(address _operator) public {
        operators[msg.sender][_operator]=false;
    }
    // Tweet = structure whereas tweets = mapping
    function getLatestTweets(uint count) view public returns(Tweet[] memory) {
        require(count>0 && count<=nextId,"Count is not proper");
        Tweet[] memory _tweets = new Tweet[](count); //Tweet type array _tweets created to store {count values}

        uint j;

        for(uint i=nextId-count;i<nextId;i++) { 
            Tweet storage _structure = tweets[i];  //Creates var of Tweet type which names as _structure and stores mapping tweets
            _tweets[j]=Tweet(_structure.id,
                             _structure.author,
                             _structure.content,
                             _structure.createdAt
                             );
            j=j+1;                 
        }
        return _tweets;
    }

    function getLatestTweetOfUser(address _from, uint _count) public view returns(Tweet[] memory){
        Tweet[] memory _tweets = new Tweet[] (_count);
        uint[] memory ids = tweetsOf[_from];
        require(_count>0 && _count <= ids.length,"Invalid Count");
        uint j;
        for(uint i = ids.length-_count;i<ids.length;i++) {
                  Tweet storage _structure = tweets[ids[i]];
                  _tweets[j]=Tweet(_structure.id,
                             _structure.author,
                             _structure.content,
                             _structure.createdAt
                             );
            j=j+1;     
        }
        return _tweets;
    }


} 