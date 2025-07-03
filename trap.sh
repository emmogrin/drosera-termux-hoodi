#!/bin/bash

echo "⚙️ Saint Khen (@admirkhen) — Trap Setup (Proot-distro, NO PATH)"
echo "twitter.com/admirkhen"
echo ""

# --------------------------------------------------------
# ✅ 1. Update & install essentials
# --------------------------------------------------------
apt-get update && apt-get upgrade -y
apt-get install -y curl git build-essential make gcc lz4 jq nano automake autoconf tmux htop unzip pkg-config libssl-dev libleveldb-dev clang bsdmainutils ncdu

# --------------------------------------------------------
# ✅ 2. Install Drosera CLI
# --------------------------------------------------------
echo "👉 Installing Drosera CLI..."
curl -L https://app.drosera.io/install | bash

# --------------------------------------------------------
# ✅ 3. Install Foundry
# --------------------------------------------------------
echo "👉 Installing Foundry..."
curl -L https://foundry.paradigm.xyz | bash

# --------------------------------------------------------
# ✅ 4. Install Bun
# --------------------------------------------------------
echo "👉 Installing Bun..."
curl -fsSL https://bun.sh/install | bash

# --------------------------------------------------------
# ✅ 5. Detect droseraup absolute location & run it directly
# --------------------------------------------------------
echo "👉 Checking Drosera installer..."
if [ -f "$HOME/.local/bin/droseraup" ]; then
  $HOME/.local/bin/droseraup
elif [ -f "$HOME/.cargo/bin/droseraup" ]; then
  $HOME/.cargo/bin/droseraup
else
  echo "❌ droseraup not found in known paths!"
  exit 1
fi

# --------------------------------------------------------
# ✅ 6. Foundry direct run
# --------------------------------------------------------
if [ -f "$HOME/.foundry/bin/foundryup" ]; then
  $HOME/.foundry/bin/foundryup
else
  echo "❌ foundryup not found!"
  exit 1
fi

# --------------------------------------------------------
# ✅ 7. Create Trap Workspace
# --------------------------------------------------------
echo "👉 Setting up trap workspace..."
mkdir -p ~/my-drosera-trap
cd ~/my-drosera-trap

# --------------------------------------------------------
# ✅ 8. Git Config
# --------------------------------------------------------
read -p "Enter your GitHub email: " GIT_EMAIL
read -p "Enter your GitHub username: " GIT_NAME
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"

# --------------------------------------------------------
# ✅ 9. Init Trap Template
# --------------------------------------------------------
echo "👉 Initializing Drosera trap..."
$HOME/.foundry/bin/forge init -t drosera-network/trap-foundry-template

$HOME/.bun/bin/bun install
$HOME/.foundry/bin/forge build

# --------------------------------------------------------
# ✅ 10. Generate drosera.toml
# --------------------------------------------------------
read -p "👉 Enter your operator wallet address: " OP_WALLET
read -p "👉 Are you an existing trap user? (y/n): " EXISTING

TRAP_ADDR_LINE=""
if [[ "$EXISTING" == "y" || "$EXISTING" == "Y" ]]; then
  read -p "👉 Enter your existing trap address: " TRAP_ADDR
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
cat drosera.toml

# --------------------------------------------------------
# ✅ 11. Apply Trap
# --------------------------------------------------------
read -p "🔑 Enter your EVM private key: " PRIVATE_KEY

if [ -f "$HOME/.local/bin/drosera" ]; then
  DROSERA_PRIVATE_KEY="$PRIVATE_KEY" $HOME/.local/bin/drosera apply
elif [ -f "$HOME/.cargo/bin/drosera" ]; then
  DROSERA_PRIVATE_KEY="$PRIVATE_KEY" $HOME/.cargo/bin/drosera apply
else
  echo "❌ drosera binary not found!"
  exit 1
fi

echo "==========================================="
echo "✅ Trap deployed successfully!"
echo "Saint Khen watches over you. 🧡"
echo "==========================================="
