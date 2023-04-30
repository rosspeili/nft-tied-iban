pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract IBANNFT is ERC721, Ownable {

    mapping (uint256 => string) private _ibanMap;

    constructor() ERC721("IBANNFT", "IBNFT") {}

    function mint(address to, uint256 tokenId, string memory iban) public onlyOwner {
        _safeMint(to, tokenId);
        _ibanMap[tokenId] = iban;
    }

    function getIBAN(uint256 tokenId) public view returns (string memory) {
        return _ibanMap[tokenId];
    }

    function transferFrom(address from, address to, uint256 tokenId) public override {
        require(
            keccak256(abi.encodePacked(_ibanMap[tokenId])) == keccak256(abi.encodePacked(_ibanMap[_tokenId])),
            "IBAN mismatch"
        );
        super.transferFrom(from, to, tokenId);
    }

}
