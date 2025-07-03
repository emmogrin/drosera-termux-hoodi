#!/usr/bin/env bash

echo "==========================================="
echo "   🚀 DROSERA HOODI FULL TRAP (PROOT-DISTRO)"
echo "==========================================="
echo "   🧡 SAINT KHEN @admirkhen on X"
echo "==========================================="

echo "👉 Updating packages..."
apt-get update && apt-get upgrade -y

echo "👉 Installing dependencies..."
apt-get install -y curl git build-essential make gcc lz4 jq nano automake autoconf tmux htop unzip pkg-config libssl-dev libleveldb-dev clang bsdmainutils ncdu

echo "👉 Installing Drosera CLI..."
curl -L https://app.drosera.io/install | bash

echo "👉 Installing Foundry CLI..."
curl -L https://foundry.paradigm.xyz | bash

echo "👉 Installing Bun..."
curl -fsSL https://bun.sh/install | bash

echo ""
echo "✅ Sourcing all known bashrc..."
source /root/.bashrc || true
source ~/.bashrc || true
source $HOME/.bashrc || true

echo ""
echo "✅ Running droseraup..."
droseraup

echo ""
echo "✅ Running foundryup..."
foundryup

echo "👉 Setting up trap workspace..."
mkdir -p ~/my-drosera-trap
cd ~/my-drosera-trap

echo "👉 Git config (change this yourself)"
git config --global user.email "youremail@example.com"
git config --global user.name "yourgithubusername"

echo "👉 Initializing Drosera Foundry trap template..."
forge init -t drosera-network/trap-foundry-template

echo "👉 Installing Node deps with Bun..."
bun install

echo "👉 Building contract..."
forge build

# Create drosera.toml
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
whitelist = ["YOUR_OPERATOR_WALLET"]
EOF

echo "✅ drosera.toml created!"
cat drosera.toml

# Deploy trap automatically
read -p "👉 Enter your EVM private key: " PRIVATE_KEY

DROSERA_PRIVATE_KEY=$PRIVATE_KEY drosera apply

echo "==========================================="
echo "✅ Trap applied automatically!"
echo "👉 You can boost later with:"
echo "drosera bloomboost --trap-address <trap_address> --eth-amount <amount>"
echo "==========================================="
echo "🎉 ALL DONE! 🚀 Saint Khen 🧡 watches over you."
echo "==========================================="
