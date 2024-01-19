# Learn Raspberry

Some saved info about the device.

# TODO:

- Try out installing debian coz its only 400mb and its base of 90% linux distros. Watch how to install by DistroTube: [Click here](https://youtu.be/-pnLU66ZFFA). Good thing is that I can have my raspbery pi attachd to my tv and I can switch to pc anytime I want, but I need to make room for the harddisk to be attached to the raspi to it all the time for that, so I can use my harddisk as a bit drive with it. Also, another reason to use debian instead of ubuntu server is that ubuntu server size is around 1.2 GB whereas the debian gui os is only 380MB only.

# Device Details

- raspberry pi4 model-b
- Processor: `Quad core ARM Cortex-A72 processor` from Specification page [here](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/specifications/).
- Archlinux supports this platform (source: [Click here](https://archlinuxarm.org/platforms/armv8)): 

  ![image](https://user-images.githubusercontent.com/31458531/202855580-b86bff0f-1ad3-4317-b70a-ddedf5840c73.png)

# Installation of ubuntu server

- Install the Ubuntu Server 64 bit using **Raspberry Pi Imager** tool (you can simply choose from the list and it'll download from internet automatically).
- Insert memcard to raspberry pi and also plug ethernet cable to it to connect to router.
- Now see the local ip address from the router's wired devices section.
- Now you can simply connect to it by `ssh ubuntu@IP` and use password `ubuntu`, and then need to set up new password as prompted when you connect to server for the first time.
- You can copy your private key file by: `ssh-copy-id -i ~/.ssh/myKeys/april-2022 pi` where pi is my ssh alias(otherwise you can use ip address in its place). Also, you must specify the private key path in `IdentityFile` key for the ssh alias definition in `~/.ssh/config` file so it picks up the private key file auotmatically when you do `ssh pi` in future.

**Connecting wifi**

***FYI: There is an automated way of making the os connect to wifi automatically on the first start if you put your wifi SSID and password to the `network-config` [file as stated here in docs of mongodb](https://www.mongodb.com/developer/products/mongodb/mongodb-on-raspberry-pi/).***

```bash
# tldr
# UPDATED for ubuntu LTS server 22.04.03 LTS when I installed on raspberry pi on 19 Jan, 2024
# Check if ssh is running on ubuntu
service ssh status

# if ssh is not installed then follow below commands
sudo apt update
sudo apt install openssh-server

systemctl status ssh
# ssh service should be active

# enable the service so it runs on startup
systemctl enable ssh
systemctl status ssh
```

1. Connecting to wifi: Install `nmtui` by command: `sudo apt install network-manager`.
2. Now we enter password via the menu we see with `nmtui` program, its fun though and connect to wifi.
3. Now we can remove the ethernet cable and just see the ip address the device gets from the same router's device page under `Wi-Fi devices` this time.
4. Now we copy that `ip address` and use username as `ubuntu` and use that in our ~/.ssh/config file (by replacing old ip address which belonged to wired connnection).
5. Now when you try to connect say by `ssh pi` we see some error like:

```bash
array@arch-os Downloads$ ssh ubuntu@192.168.18.13
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ED25519 key sent by the remote host is
SHA256:yF4hSRkQJjPHvVurHTNSonrGGzZMMcchSjO40uxIxgw.
Please contact your system administrator.
Add correct host key in /home/array/.ssh/known_hosts to get rid of this message.
Offending ED25519 key in /home/array/.ssh/known_hosts:18
Host key for 192.168.18.13 has changed and you have requested strict checking.
Host key verification failed.
```

**RESULT:** So, to fix that we need to run below commands and after that it will work simply. Source: [Click here](https://stackoverflow.com/a/23150466/10012446)

```bash
# src: https://askubuntu.com/a/9804/702911
ssh-keygen -R pi
ssh-keygen -R server.example.com
```


## Install docker

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo bash get-docker.sh
sudo usermod -aG docker $(whoami)
```

## Installing `nvm` on ubuntu server

Src: [Click here](https://github.com/nvm-sh/nvm#installing-and-updating)

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
# or
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
```

## NOTE: Running react server i.e., `react-scripts` on raspberry pi is not reliable at all

Becoz its too slow to run and changes made are even hiliariously slow. React server stared in 4 minutes for slasher frontend project. LOL.
