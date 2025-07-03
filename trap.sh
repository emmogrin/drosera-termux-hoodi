#!/bin/bash

# ----------------------------------------------
# 🚀 I see you lol
# ----------------------------------------------

echo "==========================================="
echo "   🚀 DROSERA HOODI VPS/PC TRAP FULL AUTO-SETUP 🚀"
echo "==========================================="
echo "   🧡 SAINT KHEN @admirkhen on X"
echo "==========================================="

sleep 1

echo "👉 Updating system..."
sudo apt-get update && sudo apt-get upgrade -y

echo "👉 Purging and reinstalling curl..."
sudo apt-get purge curl -y
sudo apt-get install curl -y

echo "👉 Installing dependencies..."
sudo apt install ufw iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip -y

echo "👉 Installing Drosera CLI..."
curl -L https://app.drosera.io/install | bash

echo "👉 Installing Foundry..."
curl -L https://foundry.paradigm.xyz | bash

echo "👉 Installing Bun..."
curl -fsSL https://bun.sh/install | bash

# ✅ Export paths for this session
export PATH=$HOME/.drosera/bin:$HOME/.foundry/bin:$HOME/.bun/bin:$PATH

# ✅ Make sure the binaries are reachable
source ~/.bashrc

# 🗂️ Set up trap workspace
echo "👉 Setting up trap workspace..."
mkdir -p ~/my-drosera-trap
cd ~/my-drosera-trap

echo "👉 Git config..."
read -p "Enter your GitHub email: " GIT_EMAIL
read -p "Enter your GitHub username: " GIT_NAME
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"

echo "👉 Initializing project from Drosera template..."
forge init -t drosera-network/trap-foundry-template

bun install
forge build

# Get user-specific config
read -p "👉 Enter your operator wallet address: " OP_WALLET
read -p "👉 Are you an existing trap user? (y/n): " EXISTING

TRAP_ADDR_LINE=""
if [[ "$EXISTING" == "y" || "$EXISTING" == "Y" ]]; then
  read -p "👉 Enter your existing trap address: " TRAP_ADDR
  TRAP_ADDR_LINE="address = \"$TRAP_ADDR\""
fi

# Create drosera.toml dynamically
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
whitelist = ["$OP_WALLET"]
$TRAP_ADDR_LINE
EOF

echo "✅ drosera.toml created automatically!"
cat drosera.toml

read -p "🔑 Enter your EVM private key: " PRIVATE_KEY

# ✅ USE absolute path so it NEVER fails:
DROSERA_PRIVATE_KEY="$PRIVATE_KEY" $HOME/.drosera/bin/drosera apply

echo "==========================================="
echo "✅ Trap applied automatically!"
echo "👉 If NEW, copy your trap address output."
echo "👉 If EXISTING, your trap config is updated!"
echo "👉 You can boost later with:"
echo "drosera bloomboost --trap-address <trap_address> --eth-amount <amount>"
echo "==========================================="
echo "🎉 ALL DONE! 🚀"
