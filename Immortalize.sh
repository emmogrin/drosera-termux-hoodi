#!/bin/bash

echo "🕊️ Saint Khen (@admirkhen) blesses you with IMMORTALITY (Proot-distro)"
echo "twitter.com/admirkhen"
echo ""

cd ~/my-drosera-trap || { echo "❌ Trap folder not found!"; exit 1; }

read -p "📝 Enter your Discord username (e.g., admirkhen#1234): " DISCORD_NAME
read -p "🔑 Enter your Hoodi EVM RPC URL: " ETH_RPC_URL

# Generate Trap.sol for immortality
cat <<EOF > src/Trap.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

interface IMockResponse {
    function isActive() external view returns (bool);
}

contract Trap is ITrap {
    address public constant RESPONSE_CONTRACT = 0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608;
    string constant discordName = "$DISCORD_NAME";

    function collect() external view returns (bytes memory) {
        bool active = IMockResponse(RESPONSE_CONTRACT).isActive();
        return abi.encode(active, discordName);
    }

    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory) {
        (bool active, string memory name) = abi.decode(data[0], (bool, string));
        if (!active || bytes(name).length == 0) {
            return (false, bytes(""));
        }
        return (true, abi.encode(name));
    }
}
EOF

echo "✅ Trap.sol generated."

# Update drosera.toml
sed -i 's|^path = .*|path = "out/Trap.sol/Trap.json"|' drosera.toml
sed -i 's|^response_contract = .*|response_contract = "0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608"|' drosera.toml
sed -i 's|^response_function = .*|response_function = "respondWithDiscordName(string)"|' drosera.toml
sed -i "s|^ethereum_rpc = .*|ethereum_rpc = \"$ETH_RPC_URL\"|" drosera.toml

echo "✅ drosera.toml updated."

source ~/.bashrc
forge build || { echo "❌ forge build failed"; exit 1; }
drosera dryrun || { echo "❌ Drosera dry run failed"; exit 1; }

read -p "🔑 Enter your EVM private key: " PRIVATE_KEY

DROSERA_PRIVATE_KEY="$PRIVATE_KEY" drosera apply <<< "ofc"

WALLET_ADDRESS=$(cast wallet address "$PRIVATE_KEY")
echo "🔍 Verifying on-chain for: $WALLET_ADDRESS"

sleep 5

RESPONDED=$(cast call 0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608 "isResponder(address)(bool)" "$WALLET_ADDRESS" --rpc-url "$ETH_RPC_URL")

if [ "$RESPONDED" = "true" ]; then
  echo "✅ IMMORTAL: You are now eternal on Hoodi!"
else
  echo "⚠️ Not yet immortal, check manually after a minute:"
  echo "cast call 0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608 \"isResponder(address)(bool)\" $WALLET_ADDRESS --rpc-url \"$ETH_RPC_URL\""
fi

echo "💀 Saint Khen watches over you."
