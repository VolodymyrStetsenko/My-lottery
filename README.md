
---

# 🎲 My Lottery — Sepolia (Foundry + Chainlink VRF v2.5)

> Built by **Volodymyr Stetsenko** while completing **Cyfrin Updraft – Foundry Fundamentals**.
> On-chain proof, reproducible environment, verified source, and gas reports included.

[![Solidity](https://img.shields.io/badge/Solidity-0.8.24-363636.svg)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)

---

## Overview

A decentralized lottery where:

* Users join by paying a fixed **entrance fee**.
* **Chainlink Automation** kicks off a draw when ready.
* **Chainlink VRF v2.5** returns a random winner.
* Contract transfers the pot and resets for the next round.

**Stack:** Solidity (Foundry), Chainlink VRF v2.5 & Automation, Etherscan verification.

---

## ✅ Deployment Proof (Sepolia)

* **Repo:** [https://github.com/VolodymyrStetsenko/My-lottery](https://github.com/VolodymyrStetsenko/My-lottery)

* **Contract (Verified):**
  `0xEdCE48190EE9e2085325977216beA55F7259FB4f`

  [https://sepolia.etherscan.io/address/0xedce48190ee9e2085325977216bea55f7259fb4f#code](https://sepolia.etherscan.io/address/0xedce48190ee9e2085325977216bea55f7259fb4f#code)

* **Creator / Owner:** `0xF6d3a3104b75b0BD2498856C1283e7120c315AeC`

* **Deploy Tx:**
  `0x2cfa9378a5e695cfbad5c1ce46d6a2d3ef22a8d0f767879d0f947a4a033bd38b`

* **Key Interaction Txs:**
  Enter: 
  `0x5f75e0fbccf7c923fdfce5b90011ae51879e04967122485cd60d28ee8a1e9c82`

  Upkeep/VRF req: 
  `0x42bf911c8903436d8c8ebb97148a15a0e4941f4d9e6c92a99ea7b622b210af3b`

  Extra (testing):
  `0x6fe6bc6a924715a7e90dae5077c79af4207704a6bae11dd19e25e8b48e659821`,
  `0x3284df6e0037cd9577d05b9d9045c71277b258e2ee8a38741c86ccdf884b0f32`,
  `0x15c5ba535c734309345ca8635c7c0a0e286f84c65e9747f395b266d2eb48186b`

* **VRF v2.5 Subscription ID:**
  `78327710354172325838971551030363537269547257432403460611339758998294481710333`

---

## Contract Parameters (deployed)

* **Entrance Fee:** `0.01 ETH`
* **Interval (Automation):** `30 s`
* **Callback Gas Limit:** `500,000`
* **Chainlink (Sepolia):**

  * VRF Coordinator: `0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B`
  * LINK token: `0x779877A7B0D9E8603169DdbD7836e478b4624789`
  * Gas Lane (keyHash): `0x787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae`
* **Compiler:** `0.8.24+commit.e11b9ed9`, Optimizer **enabled** (200 runs)

---

## Table of Contents

* [Overview](#overview)
* [Deployment Proof](#-deployment-proof-sepolia)
* [Contract Parameters](#contract-parameters-deployed)
* [Quickstart](#quickstart)
* [Usage](#usage)

  * [Local (Anvil)](#local-anvil)
  * [Sepolia](#sepolia-testnet)
  * [Interact (cast)](#interactions-cast)
  * [Interact (Etherscan UI)](#interact-etherscan-ui)
* [Testing & Coverage](#testing--coverage)
* [Gas Reports](#gas-reports)
* [Chainlink VRF & Automation Notes](#chainlink-vrf--automation-notes)
* [Reproducibility & Verification](#reproducibility--verification)
* [Security & Caveats](#security--caveats)
* [Credits](#credits)
* [Contact](#contact)

---

## Quickstart

**Requirements**

* [git](https://git-scm.com/) · [Foundry](https://getfoundry.sh/) · (optional) `make`, `jq`

```bash
git clone https://github.com/VolodymyrStetsenko/My-lottery
cd My-lottery
make            # clean + install deps + build
```

Create `.env` (do NOT commit):

```bash
SEPOLIA_RPC_URL=YOUR_ALCHEMY_OR_INFURA_URL
PRIVATE_KEY=0xYOUR_TEST_PRIVATE_KEY
ETHERSCAN_API_KEY=YOUR_ETHERSCAN_KEY
```

---

## Usage

### Local (Anvil)

```bash
make anvil                     # terminal A
make deploy                    # terminal B (deploys locally)
```

### Sepolia (testnet)

```bash
make deploy ARGS="--network sepolia"
# Uses foundry.toml + Makefile; reads .env for RPC & keys
```

### Interactions (cast)

```bash
export RPC=$SEPOLIA_RPC_URL
export PK=$PRIVATE_KEY
export RAFFLE=0xEdCE48190EE9e2085325977216beA55F7259FB4f

# Read
cast call $RAFFLE "getEntranceFee()(uint256)" --rpc-url $RPC
cast call $RAFFLE "getNumberOfPlayers()(uint256)" --rpc-url $RPC
cast call $RAFFLE "getRaffleState()(uint8)" --rpc-url $RPC
cast call $RAFFLE "getRecentWinner()(address)" --rpc-url $RPC

# Enter (pay exact fee from getEntranceFee)
cast send $RAFFLE "enterRaffle()" --value 0.01ether --rpc-url $RPC --private-key $PK

# Manually trigger upkeep (demo; Automation is the real trigger)
cast send $RAFFLE "performUpkeep(bytes)" 0x --rpc-url $RPC --private-key $PK
```

### Interact (Etherscan UI)

1. Open the contract on Etherscan → **Contract** → **Write Contract**.
2. Connect wallet to Sepolia.
3. Call `enterRaffle()` with **Value** `0.01` and **Unit** `ether`.
4. To demo a draw, you can `performUpkeep(bytes)` with `0x` (in production, use Automation).
5. Check **Events** and **Transactions** tabs for `RaffleEnter`, `RequestedRaffleWinner`, `WinnerPicked`.

---

## Testing & Coverage

```bash
forge test
forge test --fork-url $SEPOLIA_RPC_URL
forge coverage
```

Gas-focused micro tests live in `test/gas/RaffleGasTest.t.sol` (unit-safe, no VRF permissions needed).

---

## Gas Reports

From my runs (`forge test --gas-report`):

**Contract (selected):**

| Function               | Gas   |
| ---------------------- | ----- |
| `enterRaffle()`        | 69042 |
| `getEntranceFee()`     | 356   |
| `getNumberOfPlayers()` | 2550  |
| `getRaffleState()`     | 2607  |
| `getRecentWinner()`    | 2560  |

**How to reproduce:**

```bash
forge test --gas-report
forge snapshot            # writes .gas-snapshot
```

---

## Chainlink VRF & Automation Notes

* **VRF v2.5 subId (my sub):**
  `78327710354172325838971551030363537269547257432403460611339758998294481710333`
* **Consumer:** The deploy script adds the raffle as a consumer (see broadcast/tx logs).
* **Automation:** In production, register a Custom Logic upkeep pointing to `performUpkeep(bytes)`; interval is checked inside `checkUpkeep`.

---

## Reproducibility & Verification

* **Compiler:** `0.8.24+commit.e11b9ed9`, **optimizer enabled (200 runs)**
* **Etherscan Verified:** yes (see [code tab](https://sepolia.etherscan.io/address/0xedce48190ee9e2085325977216bea55f7259fb4f#code))

Re-verify locally (if needed):

```bash
# Example: using constructor args you can encode via cast abi-encode if you re-deploy
forge verify-contract \
  --chain-id 11155111 \
  --compiler-version v0.8.24+commit.e11b9ed9 \
  0xEdCE48190EE9e2085325977216beA55F7259FB4f \
  src/Raffle.sol:Raffle
```

List all tx hashes from your latest broadcast (for auditing):

```bash
jq -r '.transactions[].hash' broadcast/DeployRaffle.s.sol/11155111/run-latest.json
```

---

## Security & Caveats

* This is a **learning project**; not audited; **do not** use with real funds.
* VRF sub owner must add the raffle as a **consumer**; otherwise coordinator calls revert.
* Unit tests are designed for local/CI. Staging tests that need sub owner rights will revert if not configured.

---

## Credits

* Course: **Cyfrin Updraft – Foundry Fundamentals** (Patrick Collins)
  Idea inspired by the course assignment; implementation, deployment, configs, and documentation here are mine.

---

## Contact

* X: [https://x.com/carstetsen](https://x.com/carstetsen)
* Telegram: [https://t.me/Zero2Auditor](https://t.me/Zero2Auditor)
* LinkedIn: [https://www.linkedin.com/in/volodymyr-stetsenko-656014246/](https://www.linkedin.com/in/volodymyr-stetsenko-656014246/)

---

### `.env.example`

```bash
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/XXXXXXXX
PRIVATE_KEY=0xYOUR_TEST_PRIVATE_KEY
ETHERSCAN_API_KEY=YOUR_ETHERSCAN_KEY
```

### `.gitignore`

```
.env
.env.*
/out
/cache
/broadcast
/lib
/node_modules
```

---


