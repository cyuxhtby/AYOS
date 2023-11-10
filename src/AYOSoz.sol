// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/contracts/lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "../lib/contracts/lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "../lib/contracts/lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "../lib/contracts/lib/openzeppelin-contracts/contracts/utils/Counters.sol";

contract AYOS is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    mapping(uint256 => string) private _monthIpfsUris;  // From month number to IPFS URI
    
    uint256 _interval;
    uint256 _lastTimeStamp;
    uint256 _totalSupply = _tokenIdCounter.current();
    uint256 constant public MAX_SUPPLY = 100;


   constructor(uint256 interval) ERC721("AYOS Test", "AYOSTest") {
    _monthIpfsUris[0] = "ipfs://bafkreiejpzrx4dcq6hrrd5fcsprfv3nffbejydkhwo7aixm6lxwgju56ki"; 
    _monthIpfsUris[1] = "ipfs://bafkreiflxs2fofhin4gk7t3xzdmmatgv4sjyxw4adzijndr7lbnjzleosu"; 
    _monthIpfsUris[2] = "ipfs://bafkreidxsn5vf2dboj5t4ciev6ko5sova3zuzjxgeffekr2eyherbdqdji"; 
    _monthIpfsUris[3] = "ipfs://bafkreihe4qcsovdsmluj36xzp2w4xkh6g7s2bxy2m5kj7widfy2yfhlrsq";
    _monthIpfsUris[4] = "ipfs://bafkreiak6cjatxzvydvkdoe5sjxauxxvxopurdvg7cnoo4apq7wcbfs2wa";
    _monthIpfsUris[5] = "ipfs://bafkreihxudgd5424aqx7jywcko3lnvczxyyf7bfwwixzha3ubazz3xkv6u";
    _monthIpfsUris[6] = "ipfs://bafkreica677tcqyzxg4kj33tu42sl4e3iidrj7cuud5lysgqbgr3773fee";
    _monthIpfsUris[7] = "ipfs://bafkreie3kltlp4jhh3m7qfewi2r3g2si7agr4byn2c4ip2i2hkvndoiqj4";
    _monthIpfsUris[8] = "ipfs://bafkreih6lox4ksefid4fsxwkqyyrgxztulxhyb6yn5p4jwvjnhvnlwh6xe";
    _monthIpfsUris[9] = "ipfs://bafkreicbf6auez54z5psbraitvhia7diwkrzzfpwdcisjg2ag5kdxnrv6u";
    _monthIpfsUris[10] = "ipfs://bafkreibdx3zz7kn325utm6rqolgou7bvcn7bkzqekqcqbs7magsm7ow7be";
    _monthIpfsUris[11] = "ipfs://bafkreid6fh7icuw73ez23pu4yq7jfcu4yjyaapvfbk2d3aklnjxfqw3gt4";
    _monthIpfsUris[12] = "ipfs://bafkreifathnpjir4p2jdrpdfgnezezvjpchcggnlyjr4itwwta7cmf7zf4";
    _interval = interval;
    _lastTimeStamp = block.timestamp;
    }
    function checkUpkeep(bytes calldata /* checkData */) external view returns (bool upkeepNeeded, bytes memory /* performData */) {
        upkeepNeeded = (block.timestamp - _lastTimeStamp) > _interval;
        return (upkeepNeeded, ""); // explicit return statement

    }

    function performUpkeep(bytes calldata /* performData */) external {
        if ((block.timestamp - _lastTimeStamp) > _interval) {
            _lastTimeStamp = block.timestamp;
            _updateTokenUris();
        }
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        if (_totalSupply < MAX_SUPPLY){
            _safeMint(to, tokenId);
            _setTokenURI(tokenId, _monthIpfsUris[0]); // Start with default URI
        }
    }

    function _updateTokenUris() private {
        uint256 monthIndex = (block.timestamp / 30 days) % 12;
        
        for (uint256 i = 1; i <= _totalSupply; i++) {
        // Directly update the token URI without checking if the token exists.
        // This assumes that all token IDs up to totalSupply have been minted.
        _setTokenURI(i, _monthIpfsUris[monthIndex]);
        }
    }

    

    // Override _burn function from ERC721 and ERC721URIStorage
    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    // Override tokenURI function from ERC721 and ERC721URIStorage
    function tokenURI(uint256 tokenId) public view override (ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    

   
}
