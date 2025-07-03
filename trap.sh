#!/bin/bash

echo "⚙️ Saint Khen (@admirkhen) — Bulletproof Drosera Trap (Proot-distro)"
echo "twitter.com/admirkhen"
echo ""

# 🔒 Indestructible PATH
export PATH=$HOME/.local/bin:$HOME/.foundry/bin:$HOME/.bun/bin:/usr/local/bin:/usr/bin:/bin:/data/data/com.termux/files/usr/bin:$PATH
source ~/.bashrc

echo "👉 PATH is now: $PATH"

# ----------------------------------------------
# ✅ NO SUDO! Termux / proot-distro doesn't use sudo
# ----------------------------------------------

# Update & install deps
apt-get update && apt-get upgrade -y
apt-get install -y curl git build-essential make gcc lz4 jq nano automake autoconf tmux htop unzip pkg-config libssl-dev libleveldb-dev clang bsdmainutils ncdu

# Install Drosera CLI
curl -L https://app.drosera.io/install | bash
source ~/.bashrc
droseraup

# Install Foundry CLI
curl -L https://foundry.paradigm.xyz | bash
source ~/.bashrc
foundryup

# Install Bun
curl -fsSL https://bun.sh/install | bash
source ~/.bashrc

# ✅ Re-apply PATH to ensure all tools resolve
export PATH=$HOME/.local/bin:$HOME/.foundry/bin:$HOME/.bun/bin:$PATH

# Setup workspace
mkdir -p ~/my-drosera-trap
cd ~/my-drosera-trap

# Git config
read -p "📧 Enter your GitHub email: " GIT_EMAIL
read -p "👤 Enter your GitHub username: " GIT_NAME
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"

# Init trap template
forge init -t drosera-network/trap-foundry-template

bun install
forge build

# Create drosera.toml
read -p "💼 Enter your operator wallet address: " OP_WALLET
read -p "🧩 Existing trap? (y/n): " EXISTING

TRAP_ADDR_LINE=""
if [[ "$EXISTING" == "y" || "$EXISTING" == "Y" ]]; then
  read -p "🔗 Enter your existing trap address: " TRAP_ADDR
  TRAP_ADDR_LINE="address = \"$TRAP_ADDR\""
fi

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

echo "✅ drosera.toml created!"

read -p "🔑 Enter your EVM private key: " PRIVATE_KEY
DROSERA_PRIVATE_KEY="$PRIVATE_KEY" drosera apply

echo "==========================================="
echo "✅ Trap deployed successfully!"
echo "Saint Khen watches over you. 🧡"
echo "==========================================="
