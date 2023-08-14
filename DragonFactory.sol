// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

import './Creature.sol';
import './GoldenDragon.sol';

/** 
 * @title Dragon's factory contract
 * @dev Implements dragon creation process
 */
contract DragonFactory {

    Creature[] public creatures;

    struct Feature {
        string name;   // short name (up to 32 bytes)
        uint8 id; // feature ID
    }

    struct Dragon {
        string name;
        uint16 age; // weight is accumulated by delegation
        bool can_fly;  // if true, that person already voted
        address delegate; // person delegated to
        Feature[] features;   // index of the voted proposal
    }

    function createDragonContract() public {
        Creature creature = new Creature();
        creatures.push(creature);
    }

    function createGoldenDragon() public {
        Creature creature = new GoldenDragon();
        creatures.push(creature);
    }

    function makeAdult (uint256 _index) public {
        Creature creature = Creature( creatures[_index]);
        creature.addFeature('Invisible', 4);
        creature.setAge(90);
    }

    function checkIsAdult (uint256 _index) public view returns (bool) {
        Creature creature = Creature( creatures[_index]);
        return creature.getAge() > 90;
    }

}
