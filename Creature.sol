// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title Creature Contract
 * @dev Implements person creation process
 */
contract Creature {

    struct Dragon {
        string name;
        uint16 age; // weight is accumulated by delegation
        bool can_fly;  // if true, that person already voted
        address delegate; // person delegated to
        Feature[] features;   // index of the voted proposal
    }

    struct Feature {
        // If you can limit the length to a certain number of bytes, 
        // always use one of bytes1 to bytes32 because they are much cheaper
        string name;   // short name (up to 32 bytes)
        uint8 id; // feature ID
    }

    mapping(string => Feature) public allowed_features;

    Dragon public main_dragon;

    constructor() {
        allowed_features['fly'] = Feature('Fly', 1);
        allowed_features['fire'] = Feature('Fly', 2);
        allowed_features['ice'] = Feature('Fly', 3);
        allowed_features['invisible'] = Feature('Invisible', 4);

        // Feature
        Feature memory iceFeature = Feature({
            name: 'Ice',
            id: 12
        });
        
        // Push the feature to the features array
        main_dragon.features.push(iceFeature);

        // Other properties
        main_dragon.name = 'Main Dragon';
        main_dragon.age = 120;
        main_dragon.can_fly = true;
        main_dragon.delegate = address(0x1);
    }

    function getDragon() public view returns (
        string memory name, 
        uint age, 
        bool can_fly, 
        address delegate, 
        Feature[] memory features
    ) {
        return (
            main_dragon.name, 
            main_dragon.age, 
            main_dragon.can_fly, 
            main_dragon.delegate, 
            main_dragon.features
        );
    }

    function getFeature(string memory _name) public view returns (
       Feature memory features
    ) {
        return (
            allowed_features[_name]
        );
    }

    function addFeature(string memory _name, uint8 _id) public {
        // main_dragon.features.push(Feature({
            // name: _name,
            // id: _id
        // }));
        main_dragon.features.push(Feature(_name, _id));
    }

    function createFeature(string memory _name, uint8 _id) public {
        allowed_features[_name] = Feature(_name, _id);
    }

    function setAge (uint8 _val) public virtual {
        main_dragon.age = _val;
    }

    function getAge () public view returns(uint16) {
        return main_dragon.age;
    }

    function removeFeature(uint8 _id) public {
        uint8 indexToRemove = uint8(0); // initialize with an invalid value
        for (uint8 i = 0; i < main_dragon.features.length; i++) {
            if (main_dragon.features[i].id == _id) {
                indexToRemove = i + 1;
                break;
            }
        }
        require(indexToRemove != uint8(0), "Feature ID not found!");

        // remove the feature by shifting elements 
        for (uint8 i = indexToRemove - 1; i < main_dragon.features.length - 1; i++) {
            main_dragon.features[i] = main_dragon.features[i + 1];
        }
        main_dragon.features.pop();
    }

}
