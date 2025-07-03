🧡 Drosera Termux Hoodi Setup 🧡

Immortality starts here, Cadet.

Welcome to the **Termux Hoodi Setup** repo — run your Drosera Trap and Operator **directly on your phone** with `proot-distro`.  
Perfect for mobile warriors who want to stay immortal 24/7 ⚔️

> ✨ Saint Khen (@admirkhen) blesses you with immortality.  
Claim your Cadet role and rise through the Drosera ranks. 🗡️


---

🧱 What’s This?

A single stop for:

📌 Deploying your first Trap (on mobile)

📌 Running your Operator node (ARM64)

📌 Immortalizing your Discord username, on-chain forever

🏅 Claiming your Cadet Role in Discord


---

📂 Scripts Included

| File | Purpose |
| ---- | ------- |
| `trap-setup.sh` | Deploy your Trap from your phone |
| `operator-setup.sh` | Setup & run Drosera Operator on ARM |
| `immortal.sh` | Immortalize your Discord username |
| `drosera.toml` | Auto-managed config file (handled by scripts) |


---

⚙️ Setup Instructions (Termux + `proot-distro`)

🪜 **Step 0: Clone this repo inside your `proot-distro`**

```bash
apt update && sudo apt install -y git
git clone https://github.com/emmogrin/drosera-termux-hoodi.git
cd drosera-termux-hoodi
chmod +x *.sh
```

---

🧲 Step 1: Deploy Your Trap
```
./trap.sh
```
📋 You’ll be prompted for:

Your GitHub email

Your GitHub username

Your Hoodi EVM RPC URL (from Alchemy, QuickNode or PublicNode)

Your EVM private key (funded with a bit of Hoodi ETH)


✅ This sets up your trap & creates drosera.toml automatically.


---

⚙️ Step 2: Setup Drosera Operator
```
./operator.sh
```
📋 You’ll be prompted for:

Your same EVM private key

Your external IP address (can be found at whatismyipaddress.com)

Your Trap address (from previous step)


⚡ Once done, run your operator in tmux to keep it alive!


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
