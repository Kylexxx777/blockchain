// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8; // 0.9.0


// EVM, Ethereum Virtual Machine
// Avalanche, Fantom, Polygon

contract SimpleStorage {
    // Types in solidity: boolean, uint, int, address, bytes
    uint256 favoriteNumber; // intialized to 0
    mapping(string => uint256) public nameToFavoriteNumber;

    struct People{
        uint256 favoriteNumber; // indexed to 0
        string name;
    }

    // uint256[] public favorNumberList;
    People[] public people;
    

    function store(uint256 _favoriteNumber) public virtual{
        // DeclarationError: byte maximum is 32 
        favoriteNumber = _favoriteNumber;
        // favoriteNumber++; -> this code cost more gas
        // retrieve(); the only time when pure and view function cost gas is called by a function that cost gas
    }
    // DeclarationError: can't control var that set in other {}

    // It's a view function which works in the backend
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

    // It's a pure function which works in the backend
    function add() public pure returns(uint256){
        return (1+1);
    }

    // calldata, memory, storage
    function addPerson(string memory _name, uint256 _favoriteNumber) public{
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
// deploy address: 0xd9145CCE52D386f254917e481eB44e9943F39138

/*
Common Warning Type:
    ParseError: Expected ;
    Warning: SPDX license not provided
    TypeError: location must have parameter calldata, memory    
*/
