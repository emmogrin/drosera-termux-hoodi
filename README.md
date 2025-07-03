🧡 Drosera Termux Hoodi Setup 🧡

Immortality starts here, Cadet.

Welcome to the **Termux Hoodi Setup** repo — run your Drosera Trap and Operator **directly on your phone** with `proot-distro`.  
Perfect for mobile warriors who want to stay immortal 24/7 ⚔️

> ✨ Saint Khen (@admirkhen) blesses you with immortality.  
Claim your Cadet role and rise through the Drosera ranks. 🗡️


---


🧱 What’s to do before proceeding?

Everything you need to first:

📌 Get faucet 🪙 **Get free Hoodi ETH:** [QuickNode Faucet](https://faucet.quicknode.com/ethereum/hoodi/)

📌 **Add Hoodi Testnet to your wallet:** [Chainlist.org](https://chainlist.org/) [tick the include testnet box, and search hoodi.

📌 Get your local IP(Ipv4) this is for those running locally[Check your public IP here](https://whatismyipaddress.com/)

✅️ Get HOODI RPC_URL [Alchemy Dashboard](https://dashboard.alchemy.com/apps/x3e15w6dbehw92s1/networks)

OR use the PUBLIC RPC:
```
https://ethereum-hoodi-rpc.publicnode.com
```
🏅 Comment understand this post on Twitter for free hoodi eth (giveaway)


---

📂 Scripts Included

| File | Purpose |
| ---- | ------- |
| `toml.sh` | auto setup drosera.toml|
| `operator.sh` | Setup & run Drosera Operator on ARM |
| `immortalize.sh` | Immortalize your Discord username |
| `drosera.toml` | Auto-managed config file (handled by scripts) |


---

⚙️ Setup Instructions (Termux + `proot-distro`)
Download Termux from F-Droid or playstore
📲 **Download Termux APK (F-Droid version):** [Termux APK](https://f-droid.org/repo/com.termux_1002.apk)

# in Termux / Android
# Update package list
```
pkg update
```
```
pkg upgrade -y
```
# Install required packages
```
pkg install proot-distro
```
```
pkg install curl
```
```
pkg install wget
```
# Install Ubuntu
```
proot-distro install ubuntu
```
# Login ubuntu
```
proot-distro login ubuntu
```
# now inside Ubuntu
```
apt install -y
```
```
apt update && apt upgrade -y
```
```
apt install -y curl git build-essential
```
🪜 **Step 0: Install CLI 
# Drosera CLI
```
curl -L https://app.drosera.io/install | bash
source ~/.bashrc
droseraup
```

# Foundry CLI (Solidity development)
```
curl -L https://foundry.paradigm.xyz | bash
source ~/.bashrc
foundryup
```
# Bun (JavaScript runtime)
```
curl -fsSL https://bun.sh/install | bash
source ~/.bashrc
```
```
mkdir ~/my-drosera-trap
cd ~/my-drosera-trap
```

switch those fields into your actual gmail and username then paste
```
git config --global user.email "your_github_email@example.com"
git config --global user.name "your_github_username"

forge init -t drosera-network/trap-foundry-template
```
```
bun install
forge build
```
```                                                           
wget -O setup.sh https://raw.githubusercontent.com/emmogrin/drosera-termux-hoodi/main/setup.sh
wget -O trap.sh https://raw.githubusercontent.com/emmogrin/drosera-termux-hoodi/main/trap.sh
wget -O operator.sh https://raw.githubusercontent.com/emmogrin/drosera-termux-hoodi/main/operator.sh
wget -O toml.sh https://raw.githubusercontent.com/emmogrin/drosera-termux-hoodi/main/toml.sh
wget -O immortalize.sh https://raw.githubusercontent.com/emmogrin/drosera-termux-hoodi/main/immortalize.sh
chmod +x *.sh
```
This asks for your wallet address and if you are an existing user (enter n if its your First-Time using hoodi)
```
./toml.sh
```
---

Apply trap config. (Switch your_eth_private_key_here with your real private key)
```
DROSERA_PRIVATE_KEY=your_eth_private_key_here drosera apply
```
😑 Always copy the trap address as indicated below because you'll need it for the next phase
[![IMG-20250703-WA0005.jpg](https://i.postimg.cc/8cB6jc8g/IMG-20250703-WA0005.jpg)](https://postimg.cc/zHvBQJXx)
---

⚙️ Step 2: Setup Drosera Operator
```
./operator.sh
```
📋 You’ll be prompted for:

Your same EVM private key

Your external IP address (can be found at whatismyipaddress.com)

Your Trap address (from previous step)


---

🧬 Step 3: Immortalize Your Discord Username
```
./immortalize.sh
```
📋 You’ll be prompted for:

Your Discord name (e.g. admirkhen#1234)

Your EVM RPC URL (Hoodi)

Same private key


🎖️ If true — you’re immortal, Cadet! Claim your Cadet Role in Discord.


---

✅ Step 4 (Optional): Verify Your Immortality
```
source ~/.bashrc
```
```
cast call 0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608 \
"isResponder(address)(bool)" \
0xYOURWALLETADDRESS \
--rpc-url https://ethereum-hoodi-rpc.publicnode.com/
```
If it returns true — you are immortal 🧬

OR

```
cast call 0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608 \
"getDiscordNamesBatch(uint256,uint256)(string[])" \
0 2000 \
--rpc-url https://ethereum-hoodi-rpc.publicnode.com/
```
You should see your username among the output (might take some be patient)
[![Screenshot-20250703-165223-Termux.jpg](https://i.postimg.cc/4Nn0zyvX/Screenshot-20250703-165223-Termux.jpg)](https://postimg.cc/w78Fz6br)
---

💡 Tips

✔️ Use proot-distro ARM64 (Ubuntu)

✔️ Scripts auto-detect your arch & use correct Drosera binary

✔️ Keep your node alive inside tmux


---

👑 Credits

Saint Khen 🧡 Twitter: @admirkhen
Powered by Drosera Community ⚡

Go forth and claim your immortality, Cadet! ⚔️


---

🗣 Questions or stuck?

DM @admirkhen
Or join the Drosera Discord.

---
