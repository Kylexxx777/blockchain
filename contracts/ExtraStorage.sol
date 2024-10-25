// SPDX-License-Identifier: MIT

pragma solidity ^0.8.27;

import "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage{
    // +5 // overide // virtual overide
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }
}