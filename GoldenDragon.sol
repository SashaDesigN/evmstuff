// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

import './Creature.sol';

/** 
 * @title Dragon's factory contract
 * @dev Implements dragon creation process
 */
contract GoldenDragon is Creature {

    function setAge (uint8 _val) public override {
        main_dragon.age = _val + 10;
    }

}
