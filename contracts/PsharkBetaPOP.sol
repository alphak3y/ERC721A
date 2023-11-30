// SPDX-License-Identifier: MIT
// ERC721A Contracts v4.2.3
// Creator: Chiru Labs

pragma solidity ^0.8.4;

import './ERC721A.sol';

contract PoolsharkBetaPoP is ERC721A {

    address public owner;

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    constructor(
        string memory name_,
        string memory symbol_
    ) ERC721A(name_, symbol_) {
        owner = msg.sender;
    }

    function mintBatch(address[] calldata recipients) external onlyOwner {
        for (uint i; i < recipients.length;) {
            _mint(recipients[i], 1);
            unchecked {
                ++i;
            }
        }
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        if (!_exists(tokenId)) _revert(URIQueryForNonexistentToken.selector);

        string memory baseURI = _baseURI();
        return bytes(baseURI).length != 0 ? string(abi.encodePacked(baseURI)) : '';
    }

    function _baseURI() internal pure override returns (string memory) {
        return 'tokenimageURL';
    }

    function renounceOwnership() external {
        owner = address(0);
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view {
        if (owner != msg.sender) require (false, 'OwnerOnly()');
    }
}