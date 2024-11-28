# DegenWarfareToken

DegenWarfareToken (DWT) is an ERC20 token designed for the Degen Warfare gaming platform on the Avalanche network. This token facilitates in-game transactions, allowing players to purchase items, transfer tokens, and manage their in-game economy.

## Features

- **Minting New Tokens**: Only the owner can mint new tokens and distribute them to players as rewards.
- **Transferring Tokens**: Players can transfer tokens to others within the game ecosystem.
- **Redeeming Tokens**: Players can redeem their tokens for in-game items available in the virtual store.
- **Burning Tokens**: Players can burn tokens they own, reducing the total supply.
- **Checking Token Balance**: Players can check their token balance at any time.
- **In-Game Store Management**: The contract includes a store with pre-defined items and allows the owner to add new items.

## Smart Contract Overview

- **Contract Name**: `DegenWarfareToken`
- **Token Name**: Degen Warfare Token
- **Symbol**: DWT
- **Decimals**: 18 (standard for ERC20 tokens)

The contract utilizes OpenZeppelin libraries for secure and standard implementations of ERC20 and access control functionalities.

### Prerequisites

- **Solidity Compiler**: Version ^0.8.26
- **Metamask**: Browser extension configured for the Avalanche network
- **Avalanche Network Access**: Fuji Testnet or Avalanche Mainnet
- **AVAX Tokens**: Required for gas fees during deployment and transactions
