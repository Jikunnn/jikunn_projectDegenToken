// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenWarfareToken is ERC20, Ownable {
    struct Item {
        string name;
        uint256 price;
        uint256 stock;
    }

    mapping(uint256 => Item) private storeItems;
    uint256 private itemCounter;

    event ItemAdded(uint256 itemId, string name, uint256 price, uint256 stock);
    event ItemRedeemed(address indexed player, uint256 itemId, string itemName);
    event TokensBurned(address indexed account, uint256 amount);

    constructor() ERC20("Degen Warfare Token", "DWT") Ownable(msg.sender) {
        _addItem("Degen Battle Tank", 500 * 10 ** decimals(), 10);
        _addItem("Degen Assault Rifle", 200 * 10 ** decimals(), 25);
        _addItem("Degen Combat Helmet", 100 * 10 ** decimals(), 50);
    }

    // Mint new tokens to a specified address
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount * 10 ** decimals());
    }

    // Burn tokens from a specific account, callable by owner
    function burnTokensFrom(address account, uint256 amount) external onlyOwner {
        uint256 burnAmount = amount * 10 ** decimals();
        _burn(account, burnAmount);
        emit TokensBurned(account, burnAmount);
    }

    // Redeem an item using tokens
    function redeemItem(uint256 itemId) external {
        require(itemId < itemCounter, "Invalid item ID");
        Item storage item = storeItems[itemId];
        require(item.stock > 0, "Item out of stock");
        uint256 price = item.price;
        require(balanceOf(msg.sender) >= price, "Insufficient token balance");

        _burn(msg.sender, price);
        item.stock -= 1;

        emit ItemRedeemed(msg.sender, itemId, item.name);
    }

    // Transfer tokens to another address
    function transferTokens(address to, uint256 amount) external returns (bool) {
        uint256 transferAmount = amount * 10 ** decimals();
        return transfer(to, transferAmount);
    }

    // Add a new item to the store
    function addItem(string memory name, uint256 price, uint256 stock) external onlyOwner {
        _addItem(name, price * 10 ** decimals(), stock);
    }

    // Get details of a specific item by its ID
    function getItem(uint256 itemId) external view returns (string memory, uint256, uint256) {
        require(itemId < itemCounter, "Invalid item ID");
        Item storage item = storeItems[itemId];
        return (item.name, item.price / 10 ** decimals(), item.stock);
    }

    // List all items in the store
    function listItems() external view returns (Item[] memory) {
        Item[] memory items = new Item[](itemCounter);
        for (uint256 i = 0; i < itemCounter; i++) {
            Item storage item = storeItems[i];
            items[i] = Item(
                item.name, 
                item.price / 10 ** decimals(), 
                item.stock
            );
        }
        return items;
    }

    // Get the token balance of an account
    function getBalance(address account) external view returns (uint256) {
        return balanceOf(account) / 10 ** decimals();
    }

    // Internal function to add a new item to the store
    function _addItem(string memory name, uint256 price, uint256 stock) internal {
        storeItems[itemCounter] = Item(name, price, stock);
        emit ItemAdded(itemCounter, name, price / 10 ** decimals(), stock);
        itemCounter++;
    }
}
