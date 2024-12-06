// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    uint256 public potion_cost = 50;
    mapping(address => uint256) public inventory;
    constructor() ERC20("Degen", "DGN") {}

        function mint(address to, uint256 amount) public onlyOwner {
            _mint(to, amount);
    }
    function burn (uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient funds");
        _burn(msg.sender, amount);
    }
    function buyPotion(uint256 amount)public {
        uint256 cost = amount * potion_cost;
        require(balanceOf(msg.sender) >= cost, "Insufficient funds to buy");

        inventory[msg.sender] += amount;
        _burn(msg.sender, cost);
    }
    function checkInventory(address user) public view returns (uint256){
        return inventory[user];
    }
    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }
    function transferTokens(address to, uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Not enough tokens to transfer");
        _transfer(msg.sender, to, amount);
    }
          
}
