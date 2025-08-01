#!/bin/sh
apt-get -y update
apt-get -y upgrade
apt-get -y install libcurl4-openssl-dev libjansson-dev libomp-dev git screen nano jq wget
wget http://ports.ubuntu.com/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_arm64.deb
dpkg -i libssl1.1_1.1.0g-2ubuntu4_arm64.deb
rm libssl1.1_1.1.0g-2ubuntu4_arm64.deb
mkdir ~/ccminer
cd ~/ccminer
GITHUB_RELEASE_JSON=$(curl --silent "https://api.github.com/repos/Oink70/Android-Mining/releases?per_page=1" | jq -c '[.[] | del (.body)]')
GITHUB_DOWNLOAD_URL=$(echo $GITHUB_RELEASE_JSON | jq -r ".[0].assets | .[] | .browser_download_url")
GITHUB_DOWNLOAD_NAME=$(echo $GITHUB_RELEASE_JSON | jq -r ".[0].assets | .[] | .name")

echo "Downloading latest release: $GITHUB_DOWNLOAD_NAME"

wget ${GITHUB_DOWNLOAD_URL} -O ~/ccminer/ccminer
wget https://raw.githubusercontent.com/saijame-art/VerusCliMining/main/config.json -O ~/ccminer/config.json
chmod +x ~/ccminer/ccminer

cat << EOF > ~/ccminer/start.sh
#!/bin/sh
# Define a unique worker name for each miner (set this differently on each machine)
WORKER_NAME="A83-003"  # Change this for each miner
#remove old_onlineconfig.json file first and download a new one.
rm -rf ~/ccminer/onlineconfig.json
# Download the config file from GitHub
curl -o ~/ccminer/onlineconfig.json https://raw.githubusercontent.com/saijame-art/miner/refs/heads/main/onlineconfig.json

# Replace "user" field in onlineconfig.json with the wallet and unique worker name
sed -i "s/\"user\": \"[^\"]*\"/\"user\": \"RQ5XXjp6LrdZr6HCJCP6fLqVVWY8eF4MuB.$WORKER_NAME\"/" ~/ccminer/onlineconfig.json

# Run ccminer with the updated config file
~/ccminer/ccminer -c ~/ccminer/onlineconfig.json
EOF
chmod +x start.sh

echo "setup nearly complete."
echo "Edit the config with \"nano ~/ccminer/config.json\""

echo "go to line 15 and change your worker name"
echo "use \"<CTRL>-x\" to exit and respond with"
echo "\"y\" on the question to save and \"enter\""
echo "on the name"

echo "start the miner with \"cd ~/ccminer; ./start.sh\"."
