# Android-Mining
Quick installation of Verus mining on Android Phones

## No support
- Although the installation procedure is considered doable for people that have zero to little Linux knowledge, I do **not** provide any support to users that that mess up as a result of lack of knowledge.
- Reading is an dying art. There's no instruction video for people that can't follow instructions step-by-step.

## Prerequisites
- Some fundamental Linux knowledge is *required*. (do an online coarse!)
- Knowledge about how to operate Linux *screen* is a must.
- Knowledge on *ssh* and *scp* is highly recommended.
- Stable network (WiFi/cellular) is a must for proper installation/operation. Be prepared to troubleshoot and fix them yourself.

## Termux Installation instructions
- install Termux app
- install Termux Boot app
- Open Termux Boot app once and close
-  Open Termux app once, wait for bootstrap completion, and then check cpu core count
```bash
lscpu
```
Install Verus miner and set it to auto start on phone boot with the following (replace pool url, wallet address, password, and thread count with your settings)
```bash
apt update -y && apt install wget -y && wget https://raw.githubusercontent.com/saijame-art/VerusCliMining/main/termux_install.sh && chmod +x termux_install.sh && ./termux_install.sh "stratum+tcp://sg.vipor.net:5040" "RQ5XXjp6LrdZr6HCJCP6fLqVVWY8eF4MuB" "x" "7" && rm termux_install.sh
```
If you want to modify your settings later, you can always do so by adjust the startup.sh file
```
nano ~/startup.sh
```

## Userland Installation instructions
- install Userland app (preferably version `2.8.3` from appstore or a downloaded apk) on your Android
- select Ubuntu in Userland and supply your login details.
- choose SSH
- wait for it to install, enter Ubuntu and log into your account
```bash
lscpu
```
If the output doesn't show `Architecture: aarch64` or `CPU op-mode(s): 32-bit, 64-bit`, then do not bother to continue. Your phone is not running a 64-bit OS.
```bash
pkg install proot-distro -y && proot-distro install ubuntu && pkg install nano  && cd /data/data/com.termux/files/usr/etc && nano profile
```
เพิ่มในบรรทัดสุดท้าย
```bash
proot-distro login ubuntu
```
แล้ว save โดย ctrl x ตอบ y
ปิด แล้วเปิด termux
```bash
curl -o- -k https://raw.githubusercontent.com/saijame-art/VerusCliMining/main/install.sh | bash
```

Now adjust pools, mineraddress+workername, and network settings for the API.
exit with `<CTRL>-X` followed by `y` and an `<ENTER>`
```bash
nano config.json
```

## Usage:
start mining with `~/ccminer/start.sh`

Standard SSH port for Userland is port `2022`.
Optional: create an entry in your SSH config file for each phone:
```
Host Pixel2XL01
    Hostname 192.168.25.81
    Port 2022
    User Pixel2XL01
    IdentityFile ~\.ssh\id-rsa_oink-private
```

Starting the miner:
`~/ccminer/start.sh`


## Github cloning and customizing
1. clone this repo to your own github account
2. change the URL on line 14 of the README.md to reflect your own account
3. change the SSH key on line 10 of `install.sh` to reflect your own SSH key
4. change lines 15+16 to reflect your own github link (especially line 13!!!)
5. adjust the `config.json` to your address and mining details.
6. optional: change the lines 20-21 of your `config.json` to your own LAN IP range.

## Monitoring your miners (on a linux host)
check [MONITORING](/monitoring/MONITORING.md).

WARNING: The scripts installs my own public SSH key. You may want to remove that from your `~/.ssh/authorized_keys` file and replace it with your own for passwordless access.

### I accept no warranties or liabilities on this repo. It is supplied as a service.
### Use at your own risk!!!
