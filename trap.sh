#!/bin/bash

echo "🐍 Saint Khen (@admirkhen) — Trap Deployment (Proot-distro)"
echo "twitter.com/admirkhen"
echo ""

# Install essentials (only run once if needed)
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install curl git build-essential make gcc lz4 jq nano automake autoconf tmux htop unzip pkg-config libssl-dev libleveldb-dev clang bsdmainutils ncdu -y

# Drosera CLI
curl -L https://app.drosera.io/install | bash
source ~/.bashrc
droseraup

# Foundry CLI
curl -L https://foundry.paradigm.xyz | bash
source ~/.bashrc
foundryup

# Bun
curl -fsSL https://bun.sh/install | bash
source ~/.bashrc

# Clone & prepare trap
mkdir -p ~/my-drosera-trap
cd ~/my-drosera-trap

git config --global user.email "youremail@example.com"
git config --global user.name "yourgithubname"

forge init -t drosera-network/trap-foundry-template

bun install
forge build

# Generate drosera.toml
cat <<EOF > drosera.toml
ethereum_rpc = "https://ethereum-hoodi-rpc.publicnode.com"
drosera_rpc = "https://relay.hoodi.drosera.io"
eth_chain_id = 560048
drosera_address = "0x91cB447BaFc6e0EA0F4Fe056F5a9b1F14bb06e5D"

[traps]

[traps.helloworld]
path = "out/HelloWorldTrap.sol/HelloWorldTrap.json"
response_contract = "0x183D78491555cb69B68d2354F7373cc2632508C7"
response_function = "helloworld(string)"
cooldown_period_blocks = 33
min_number_of_operators = 1
max_number_of_operators = 2
block_sample_size = 10
private_trap = true
whitelist = ["YOUR_OPERATOR_WALLET_ADDRESS"]

# If existing, uncomment:
# address = "PASTE_EXISTING_TRAP_ADDRESS_HERE"
EOF

echo "✅ drosera.toml created!"

# Prompt for private key & apply trap
read -p "🔑 Enter your EVM private key: " PRIVATE_KEY

DROSERA_PRIVATE_KEY="$PRIVATE_KEY" drosera apply <<< "ofc"

echo "✅ Trap deployed."
