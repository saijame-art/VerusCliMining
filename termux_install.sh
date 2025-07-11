apt update -y 
apt install libcurl openssl libjansson automake build-essential screen git -y
git clone --single-branch -b ARM https://github.com/monkins1010/ccminer.git
cd ccminer
chmod +x build.sh
chmod +x configure.sh
chmod +x autogen.sh
./build.sh
cd ~
#echo "screen -dmS miner ~/ccminer/ccminer -a verus -o stratum+tcp://sg.vipor.net:3960 -u RQ5XXjp6LrdZr6HCJCP6fLqVVWY8eF4MuB -p x -t 7" > startup.sh
echo "screen -dmS miner ~/ccminer/ccminer -a verus -o $1 -u $2 -p $3 -t $4" > startup.sh
chmod +x startup.sh
mkdir -p ~/.termux/boot
wget https://raw.githubusercontent.com/saijame-art/VerusCliMining/refs/heads/main/termux_boot_startup.sh -O ~/.termux/boot/termux_boot_startup.sh
~/startup.sh
echo "------------------------------"
echo "Miner is installed and running. Update config using nano startup.sh"
echo "To view miner now or after restart, use screen -r miner"
echo "------------------------------"
