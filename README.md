```markdown
# Ethereum Lottery Smart Contract

This repository contains the Ethereum smart contract for a decentralized lottery system. The contract allows participants to enter a lottery by paying a fixed ticket price, with the ability to start new lottery rounds, join ongoing ones, and pick a winner in a trustless and transparent manner.

## Features

- **Start a Lottery:** Users can start a new lottery round by paying a minimum fee.
- **Join a Lottery:** Participants can join an active lottery round by purchasing a lottery ticket.
- **View Lottery Details:** Users can view details of each lottery round, including participants, prize pool, and the winner.
- **Pick a Winner:** The lottery round initiator can pick a winner in a fair and random manner.

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/)
- [Truffle](https://www.trufflesuite.com/)
- [Ganache](https://www.trufflesuite.com/ganache) for a local Ethereum blockchain

### Installation

1. Clone the repository
   ```
   git clone https://github.com/ChippuArt/lottery-ethereum.git
   ```
2. Install dependencies
   ```
   npm install
   ```
3. Compile the smart contract
   ```
   truffle compile
   ```

### Deployment

1. Start Ganache to run a local Ethereum blockchain.
2. Deploy the contract to Ganache
   ```
   truffle migrate --network development
   ```

### Interacting with the Contract

You can interact with the contract using Truffle console:

```bash
truffle console
```

Then, you can start a lottery, join a lottery, and pick a winner using the contract's functions:

```javascript
const lottery = await Lottery.deployed();
```

## Testing

To run the predefined tests for the smart contract:

```bash
truffle test
```

## Built With

- [Solidity](https://soliditylang.org/) - The programming language used to create the smart contract.
- [Truffle](https://www.trufflesuite.com/) - A development framework for Ethereum.

## License

This project is licensed under the SEE LICENSE IN LICENSE - see the [LICENSE.md](LICENSE.md) file for details.
