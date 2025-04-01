// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6; 

/*
  GM its 20/02/25 and Im Mohit here, planning to build a simple property registration dapp where a 
  authority/manager registers all the property information such as -1.owner, 
                                                                    2.owningFromDate,
                                                                    3.landType,
                                                                    4.landSize,
                                                                    5.location,
                                                                    6.ownerId,
                                                                    7.totalProperUserOwn,
                                                                    8.isForSell,
                                                                    9.userIdentity,
                                                                    10.Management authorities,
                                                                    11.Nomniee,
                                                                    
-----------------------------------------------------------------------------------------------------
 ***    Function for Admin      ***
    1. Register property --done
    2. Transfer Ownership
    3. See All properties
                                                                        

-----------------------------------------------------------------------------------------------------
 ***    Function for PropertyOwners      ***
    1. Accept and Send Buy or Sell Offers
*/
contract PropDapp {

  address owner;
  constructor () {
    owner = msg.sender;
  }
   modifier onlyOwner () {
    require(msg.sender == owner, "You're not owner");
    _;
   }

   struct Property {
    uint propId;
    string ownerName;
    address ownerAddress;
    string propLocation;
    }
    uint nextPropertyId = 1;
    mapping (uint => Property) propertyDetails;

    // Function to register property by manager
    function registerProperty (
      string calldata  _ownerName,
      address _ownerAddress,
      string calldata _propLocation
    ) public onlyOwner{
      propertyDetails[nextPropertyId] = Property (
        {
            propId : nextPropertyId,
            ownerName : _ownerName,
            ownerAddress : _ownerAddress,
            propLocation : _propLocation
        }
      );
      nextPropertyId++;
      }

    function seeAllProperty () public view returns (Property [] memory) {
      uint _length = Property.length;
      Property [] memory AllPropertyDetails;

      for (uint i = 0; i < _length; i++) {
        AllPropertyDetails[i] = propertyDetails[propId[i]];
      }
    }
    

}