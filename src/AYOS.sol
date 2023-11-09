// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "../lib/contracts/contracts/base/ERC721Drop.sol";

contract AYOS is ERC721Drop { 
     constructor(
        address _defaultAdmin,
        string memory _name,
        string memory _symbol,
        address _royaltyRecipient,
        uint128 _royaltyBps,
        address _primarySaleRecipient
    )
        ERC721Drop(
            _defaultAdmin,
            _name,
            _symbol,
            _royaltyRecipient,
            _royaltyBps,
            _primarySaleRecipient
        )
    {}

    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }
}
