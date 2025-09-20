
---

# 🎲 My Lottery — Sepolia (Foundry + Chainlink VRF v2.5)


[![Solidity](https://img.shields.io/badge/Solidity-0.8.24-363636.svg)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)


This repository contains the smart contract for a decentralized lottery, developed as part of the **Cyfrin Updraft – Foundry Fundamentals** course. This project demonstrates proficiency in Solidity smart contract development using Foundry, integrating Chainlink VRF v2.5 for provably fair randomness and Chainlink Automation for automated upkeep.

## Table of Contents

*   [Project Overview](#project-overview)
*   [Features](#features)
*   [Deployment Proof (Sepolia Testnet)](#deployment-proof-sepolia-testnet)
*   [Contract Parameters](#contract-parameters)
*   [Getting Started](#getting-started)
    *   [Requirements](#requirements)
    *   [Quickstart](#quickstart)
    *   [Environment Variables](#environment-variables)
*   [Usage](#usage)
    *   [Local Development (Anvil)](#local-development-anvil)
    *   [Deployment to Sepolia Testnet](#deployment-to-sepolia-testnet)
    *   [Interacting with the Contract (Cast)](#interacting-with-the-contract-cast)
    *   [Interacting via Etherscan UI](#interacting-via-etherscan-ui)
*   [Testing & Coverage](#testing--coverage)
*   [Gas Reports](#gas-reports)
*   [Chainlink VRF & Automation Notes](#chainlink-vrf--automation-notes)
*   [Reproducibility & Verification](#reproducibility--verification)
*   [Security & Caveats](#security--caveats)
*   [Credits](#credits)
*   [Contact](#contact)
*   [License](#license)

## Project Overview

This project implements a fully decentralized lottery system on the Sepolia testnet. The core functionality revolves around a smart contract that manages player entries, selects a random winner, and distributes the prize pool. The system leverages cutting-edge Web3 technologies to ensure transparency, fairness, and automation.

Key aspects of the lottery include:

*   **Decentralized Entry:** Users can join the lottery by paying a fixed entrance fee directly to the smart contract.
*   **Automated Draws:** Chainlink Automation is utilized to periodically check conditions and trigger the lottery draw process without manual intervention.
*   **Provably Fair Randomness:** Chainlink VRF (Verifiable Random Function) v2.5 is integrated to provide a secure and auditable source of randomness for selecting the winner, ensuring that no participant or external entity can manipulate the outcome.
*   **Automated Payouts:** Upon a winner being selected, the contract automatically transfers the entire prize pot to the winning address and resets itself for the next round of the lottery.

This project serves as a practical demonstration of building robust and secure decentralized applications (dApps) using the Foundry development toolkit and Chainlink's oracle services.

## Features

*   **Solidity Smart Contract:** Core logic written in Solidity, adhering to best practices for secure and efficient contract development.
*   **Foundry Development Environment:** Built and tested using Foundry, a blazing fast, portable, and modular toolkit for Ethereum application development.
*   **Chainlink VRF v2.5 Integration:** Secure and verifiable on-chain randomness for winner selection.
*   **Chainlink Automation Integration:** Decentralized, event-driven execution of contract functions, enabling automated lottery draws.
*   **Etherscan Verification:** Contract source code is verified on Etherscan for transparency and auditability.
*   **Comprehensive Testing:** Includes unit, integration, and forked tests to ensure contract reliability and correctness.
*   **Gas Optimization:** Designed with gas efficiency in mind, including detailed gas reports.

## Deployment Proof (Sepolia Testnet)

All deployments and interactions were performed on the Sepolia testnet. The following details provide on-chain proof of the contract's existence and key operations:

*   **Contract Address (Verified):** `0xEdCE48190EE9e2085325977216beA55F7259FB4f` [[1]](https://sepolia.etherscan.io/address/0xEdCE48190EE9e2085325977216beA55F7259FB4f)
*   **Creator / Owner Address:** `0xF6d3a3104b75b0BD2498856C1283e7120c315AeC` [[2]](https://sepolia.etherscan.io/address/0xF6d3a3104b75b0BD2498856C1283e7120c315AeC)
*   **Deployment Transaction:** `0x2cfa9378a5e695cfbad5c1ce46d6a2d3ef22a8d0f767879d0f947a4a033bd38b` [[3]](https://sepolia.etherscan.io/tx/0x2cfa9378a5e695cfbad5c1ce46d6a2d3ef22a8d0f767879d0f947a4a033bd38b)
*   **Key Interaction Transactions:**
    *   **Enter Raffle:** `0x5f75e0fbccf7c923fdfce5b90011ae51879e04967122485cd60d28ee8a1e9c82` [[4]](https://sepolia.etherscan.io/tx/0x5f75e0fbccf7c923fdfce5b90011ae51879e04967122485cd60d28ee8a1e9c82)
    *   **Upkeep/VRF Request:** `0x42bf911c8903436d8c8ebb97148a15a0e4941f4d9e6c92a99ea7b622b210af3b` [[5]](https://sepolia.etherscan.io/tx/0x42bf911c8903436d8c8ebb97148a15a0e4941f4d9e6c92a99ea7b622b210af3b)
    *   **Additional Testing Transactions:**
        *   `0x6fe6bc6a924715a7e90dae5077c79af4207704a6bae11dd19e25e8b48e659821` [[6]](https://sepolia.etherscan.io/tx/0x6fe6bc6a924715a7e90dae5077c79af4207704a6bae11dd19e25e8b48e659821)
        *   `0x3284df6e0037cd9577d05b9d9045c71277b258e2ee8a38741c86ccdf884b0f32` [[7]](https://sepolia.etherscan.io/tx/0x3284df6e0037cd9577d05b9d9045c71277b258e2ee8a38741c86ccdf884b0f32)
        *   `0x15c5ba535c734309345ca8635c7c0a0e286f84c65e9747f395b266d2eb48186b` [[8]](https://sepolia.etherscan.io/tx/0x15c5ba535c734309345ca8635c7c0a0e286f84c65e9747f395b266d2eb48186b)
*   **Chainlink VRF v2.5 Subscription ID:** `78327710354172325838971551030363537269547257432403460611339758998294481710333`

## Contract Parameters

The lottery contract was deployed with the following key parameters:

*   **Entrance Fee:** `0.01 ETH`
*   **Interval (Chainlink Automation):** `30 seconds`
*   **Callback Gas Limit:** `500,000`
*   **Chainlink (Sepolia Testnet) Specifics:**
    *   **VRF Coordinator:** `0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B`
    *   **LINK Token:** `0x779877A7B0D9E8603169DdbD7836e478b4624789`
    *   **Gas Lane (keyHash):** `0x787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae`
*   **Solidity Compiler Version:** `0.8.24+commit.e11b9ed9`
*   **Optimizer:** Enabled with `200` runs.

## Getting Started

To set up and interact with this project, follow the instructions below. This guide assumes a Linux Ubuntu environment, consistent with the development setup.

### Requirements

Before you begin, ensure you have the following installed:

*   **Git:** For cloning the repository.
    ```bash
git --version
    ```
    (Expected output: `git version x.x.x`)
*   **Foundry:** The smart contract development toolkit.
    ```bash
forge --version
    ```
    (Expected output: `forge 0.2.0 (816e00b 2023-03-16T00:05:26.396218Z)` or similar)
*   **(Optional) `make` and `jq`:** For simplified command execution and JSON parsing.

### Quickstart

1.  **Clone the repository:**
    ```bash
git clone https://github.com/VolodymyrStetsenko/My-lottery
cd My-lottery
    ```
2.  **Install dependencies and build the project:**
    ```bash
make # This command typically runs 'clean', 'install deps', and 'build'
    ```

### Environment Variables

To interact with the Sepolia testnet and verify contracts, you need to set up environment variables. Create a `.env` file in the root of your project (this file should **not** be committed to version control):

```dotenv
SEPOLIA_RPC_URL=YOUR_ALCHEMY_OR_INFURA_URL
PRIVATE_KEY=0xYOUR_TEST_PRIVATE_KEY
ETHERSCAN_API_KEY=YOUR_ETHERSCAN_KEY
```

*   `SEPOLIA_RPC_URL`: Your RPC URL for the Sepolia testnet (e.g., from Alchemy or Infura).
*   `PRIVATE_KEY`: The private key of your test account (ensure it's an account without real funds).
*   `ETHERSCAN_API_KEY`: Your API key from Etherscan, required for contract verification.

## Usage

This section details how to deploy, interact with, and test the lottery smart contract.

### Local Development (Anvil)

For local development and testing, you can use Anvil, Foundry's local blockchain node.

1.  **Start Anvil in a separate terminal:**
    ```bash
make anvil
    ```
2.  **Deploy the contract to your local Anvil instance:**
    ```bash
make deploy
    ```

### Deployment to Sepolia Testnet

To deploy the contract to the Sepolia testnet:

```bash
make deploy ARGS="--network sepolia"
```

This command uses the `foundry.toml` configuration and `Makefile` to read your environment variables (`SEPOLIA_RPC_URL`, `PRIVATE_KEY`) for deployment.

### Interacting with the Contract (Cast)

`cast` is Foundry's CLI tool for interacting with EVM smart contracts. Ensure your environment variables (`RPC`, `PK`, `RAFFLE`) are set as shown below, replacing `0xEdCE48190EE9e2085325977216beA55F7259FB4f` with your deployed contract address if different.

```bash
export RPC=$SEPOLIA_RPC_URL
export PK=$PRIVATE_KEY
export RAFFLE=0xEdCE48190EE9e2085325977216beA55F7259FB4f

# Read contract state variables
cast call $RAFFLE "getEntranceFee()(uint256)" --rpc-url $RPC
cast call $RAFFLE "getNumberOfPlayers()(uint256)" --rpc-url $RPC
cast call $RAFFLE "getRaffleState()(uint8)" --rpc-url $RPC
cast call $RAFFLE "getRecentWinner()(address)" --rpc-url $RPC

# Enter the raffle (ensure you send the exact entrance fee)
cast send $RAFFLE "enterRaffle()" --value 0.01ether --rpc-url $RPC --private-key $PK

# Manually trigger upkeep (for demonstration purposes; Chainlink Automation handles this in production)
cast send $RAFFLE "performUpkeep(bytes)" 0x --rpc-url $RPC --private-key $PK
```

### Interacting via Etherscan UI

For a user-friendly interaction experience, you can use the Etherscan interface:

1.  Navigate to the [verified contract on Etherscan](https://sepolia.etherscan.io/address/0xEdCE48190EE9e2085325977216beA55F7259FB4f).
2.  Go to the **Contract** tab and then select **Write Contract**.
3.  Connect your Web3 wallet (e.g., MetaMask) to the Sepolia network.
4.  To enter the raffle, find the `enterRaffle()` function, set the **Value** to `0.01` and the **Unit** to `ether`, then click **Write**.
5.  To simulate a draw (for testing purposes), you can call `performUpkeep(bytes)` with `0x` as the `bytes` argument. In a production environment, Chainlink Automation would trigger this function.
6.  Monitor the **Events** and **Transactions** tabs on Etherscan for `RaffleEnter`, `RequestedRaffleWinner`, and `WinnerPicked` events to track the lottery's progress.

## Testing & Coverage

This project includes a comprehensive suite of tests to ensure the smart contract functions as expected. Foundry's `forge` is used for testing and coverage analysis.

*   **Run all tests:**
    ```bash
forge test
    ```
*   **Run tests with forking (against Sepolia):**
    ```bash
forge test --fork-url $SEPOLIA_RPC_URL
    ```
*   **Generate test coverage report:**
    ```bash
forge coverage
    ```

Gas-focused micro tests are located in `test/gas/RaffleGasTest.t.sol`. These tests are designed to be unit-safe and do not require VRF permissions.

## Gas Reports

Gas usage is a critical aspect of smart contract development. Detailed gas reports were generated during testing to identify and optimize gas consumption. Below are selected gas figures from my runs (obtained using `forge test --gas-report`):

| Function           | Gas   |
| :----------------- | :---- |
| `enterRaffle()`    | 69042 |
| `getEntranceFee()` | 356   |
| `getNumberOfPlayers()` | 2550  |
| `getRaffleState()` | 2607  |
| `getRecentWinner()`| 2560  |

To reproduce these gas reports:

```bash
forge test --gas-report
forge snapshot # This command writes a .gas-snapshot file
```

## Chainlink VRF & Automation Notes

This project heavily relies on Chainlink's decentralized oracle networks for randomness and automation.

*   **VRF v2.5 Subscription ID:** My personal subscription ID used for this project is `78327710354172325838971551030363537269547257432403460611339758998294481710333`.
*   **Consumer Management:** The deployment script automatically adds the lottery contract as a consumer to the VRF subscription. This can be verified by checking the broadcast/transaction logs.
*   **Chainlink Automation:** In a production environment, a Custom Logic upkeep would be registered on [automation.chain.link](https://automation.chain.link/) pointing to the `performUpkeep(bytes)` function of the lottery contract. The `checkUpkeep` function within the contract determines when the upkeep needs to be performed.

## Reproducibility & Verification

Ensuring the reproducibility and verifiability of smart contracts is paramount for trust and security.

*   **Compiler Details:** The contract was compiled with Solidity version `0.8.24+commit.e11b9ed9`, with the optimizer enabled for `200` runs.
*   **Etherscan Verification:** The contract source code is fully verified on Etherscan, allowing anyone to audit the deployed code against the source. You can view the verified code under the 'Code' tab on the [contract's Etherscan page](https://sepolia.etherscan.io/address/0xEdCE48190EE9e2085325977216beA55F7259FB4f#code).

To re-verify the contract locally (if needed):

```bash
forge verify-contract \
  --chain-id 11155111 \
  --compiler-version v0.8.24+commit.e11b9ed9 \
  0xEdCE48190EE9e2085325977216beA55F7259FB4f \
  src/Raffle.sol:Raffle
```

To list all transaction hashes from the latest deployment broadcast (useful for auditing and tracking):

```bash
jq -r '.transactions[].hash' broadcast/DeployRaffle.s.sol/11155111/run-latest.json
```

## Security & Caveats

**Important Considerations:**

*   **Learning Project:** This project was developed as a learning exercise during the Cyfrin Updraft course. It has **not** undergone a formal security audit. **DO NOT use this contract with real funds in a production environment.**
*   **VRF Consumer:** The VRF subscription owner must explicitly add the lottery contract as a consumer. Failure to do so will result in coordinator calls reverting.
*   **Test Environment:** Unit tests are primarily designed for local execution and CI/CD pipelines. Staging tests that require VRF subscription owner rights may revert if the environment is not configured correctly.

## Credits

This project was completed as part of the **Cyfrin Updraft – Foundry Fundamentals** course by Patrick Collins. While the core idea was inspired by the course assignment, the implementation, deployment, configuration, and comprehensive documentation presented here are my original work.

*   **Course:** [Cyfrin Updraft – Foundry Fundamentals](https://updraft.cyfrin.io/courses/foundry)
*   **Instructor:** Patrick Collins

## Contact

I am always open to connecting and discussing Web3 development. Feel free to reach out:

*   **X (formerly Twitter):** [https://x.com/carstetsen](https://x.com/carstetsen)
*   **Telegram:** [https://t.me/Zero2Auditor](https://t.me/Zero2Auditor)
*   **LinkedIn:** [https://www.linkedin.com/in/volodymyr-stetsenko-656014246/](https://www.linkedin.com/in/volodymyr-stetsenko-656014246/)

## License

This project is licensed under the MIT License. See the `LICENSE` file for details. 

[1]: https://sepolia.etherscan.io/address/0xEdCE48190EE9e2085325977216beA55F7259FB4f
[2]: https://sepolia.etherscan.io/address/0xF6d3a3104b75b0BD2498856C1283e7120c315AeC
[3]: https://sepolia.etherscan.io/tx/0x2cfa9378a5e695cfbad5c1ce46d6a2d3ef22a8d0f767879d0f947a4a033bd38b
[4]: https://sepolia.etherscan.io/tx/0x5f75e0fbccf7c923fdfce5b90011ae51879e04967122485cd60d28ee8a1e9c82
[5]: https://sepolia.etherscan.io/tx/0x42bf911c8903436d8c8ebb97148a15a0e4941f4d9e6c92a99ea7b622b210af3b
[6]: https://sepolia.etherscan.io/tx/0x6fe6bc6a924715a7e90dae5077c79af4207704a6bae11dd19e25e8b48e659821
[7]: https://sepolia.etherscan.io/tx/0x3284df6e0037cd9577d05b9d9045c71277b258e2ee8a38741c86ccdf884b0f32
[8]: https://sepolia.etherscan.io/tx/0x15c5ba535c734309345ca8635c7c0a0e286f84c65e9747f395b266d2eb48186b

