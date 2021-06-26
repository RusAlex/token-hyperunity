// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract Token is Ownable, ERC20Capped {
    /* uint256 private value; */
    address  constant public TREASURE_ADDRESS = 0xD57196e9d2D2980647A04aFa5dB83F3919117A5d;
    address  constant public DEV_ADDRESS = 0x9A4fA16Cc8eEfE428A0eD0e3feCA1290dF7D32f0;
    address  constant public COLLATERAL_ADDRESS = 0xA8e0250eC7F57Ad8107C8Df3138838e02d856434;

    constructor() public ERC20("HyperUnity", "HYCO") ERC20Capped(10000 * 10**6 * 10**18) {
        uint256 cap = 10000 * 10**6 * 10**18;
        uint256 treasure = 500 * 10**6 * 10**18;
        uint256 dev = 500 * 10**6* 10**18;
        uint256 collateral = 1000*  10**6* 10**18;
        uint256 owner = 7800 * 10**6* 10**18;
        uint256 initialBalance = treasure + dev + collateral + owner;
        require(initialBalance <= cap, "CommonERC20: cap exceeded"); // this is needed to know for sure the cap is not exceded.
        ERC20._mint(msg.sender, owner);
        ERC20._mint(TREASURE_ADDRESS, treasure);
        ERC20._mint(DEV_ADDRESS, dev);
        ERC20._mint(COLLATERAL_ADDRESS, collateral);
    }

    function mint(address addr, uint256 amount) public onlyOwner {
        ERC20._mint(addr, amount * 10**18);
    }
}
