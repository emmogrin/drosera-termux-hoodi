#!/bin/bash

echo "⚙️ Saint Khen (@admirkhen) — Operator Setup (Proot-distro)"
echo "twitter.com/admirkhen"
echo ""

mkdir -p ~/drosera-operator
cd ~/drosera-operator

# Download ARM binary
curl -L -o drosera-operator.tar.gz https://github.com/drosera-network/releases/releases/download/v1.20.0/drosera-operator-v1.20.0-aarch64-unknown-linux-gnu.tar.gz
tar -xvzf drosera-operator.tar.gz
chmod +x drosera-operator

read -p "🔑 Enter your EVM private key: " PRIVATE_KEY
read -p "📡 Enter your VPS IP: " VPS_IP

./drosera-operator register \
  --eth-rpc-url https://ethereum-hoodi-rpc.publicnode.com \
  --eth-private-key "$PRIVATE_KEY" \
  --drosera-address 0x91cB447BaFc6e0EA0F4Fe056F5a9b1F14bb06e5D

read -p "🧩 Enter your trap address to opt-in: " TRAP_ADDRESS

./drosera-operator optin \
  --eth-rpc-url https://ethereum-hoodi-rpc.publicnode.com \
  --eth-private-key "$PRIVATE_KEY" \
  --trap-config-address "$TRAP_ADDRESS"

echo ""
echo "✅ Operator registered & opted in."

echo "➡️ To run your node:"
echo "./drosera-operator node --db-file-path ~/.drosera.db --network-p2p-port 31313 --server-port 31314 --eth-rpc-url https://ethereum-hoodi-rpc.publicnode.com --drosera-address 0x91cB447BaFc6e0EA0F4Fe056F5a9b1F14bb06e5D --eth-private-key $PRIVATE_KEY --listen-address 0.0.0.0 --network-external-p2p-address $VPS_IP --disable-dnr-confirmation true --eth-chain-id 560048"
