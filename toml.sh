#!/bin/bash

echo "==========================================="
echo " ⚙️  DROSERA — TRAP TOML GENERATOR"
echo "==========================================="

# Always go to your trap project folder
cd ~/my-drosera-trap || { echo "❌ Directory ~/my-drosera-trap does not exist!"; exit 1; }

echo "👉 Inside $(pwd)"

read -p "👉 Enter your OPERATOR WALLET ADDRESS: " OP_WALLET
read -p "👉 Are you an EXISTING trap user? (y/n): " EXISTING

TRAP_ADDR_LINE=""
if [[ "$EXISTING" == "y" || "$EXISTING" == "Y" ]]; then
  read -p "👉 Enter your EXISTING TRAP ADDRESS: " TRAP_ADDR
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

echo ""
echo "✅ drosera.toml created successfully!"
echo "👉 Showing result:"
echo "-------------------------------------------"
cat drosera.toml
echo "-------------------------------------------"
