// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.21;

contract DummyInformation {
    mapping(uint => address) public information;

    constructor(address[] memory _information){
        for (uint i; i < _information.length; i++){
            information[i] = _information[i];
        }
    }
}