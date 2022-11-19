# Learn Raspberry

Some saved info about the device.

## Quick Links

- Official Article: Installing mongodb on 64 bit raspberry processor: [Click here ](https://www.mongodb.com/developer/products/mongodb/mongodb-on-raspberry-pi/)

# Device Details

- raspberry pi4 model-b
- Processor: `Quad core ARM Cortex-A72 processor` from Specification page [here](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/specifications/).
- Archlinux supports this platform (source: [Click here](https://archlinuxarm.org/platforms/armv8)): 

  ![image](https://user-images.githubusercontent.com/31458531/202855580-b86bff0f-1ad3-4317-b70a-ddedf5840c73.png)

# Installation of ubuntu server s

- Install the Ubuntu Server 64 bit using **Raspberry Pi Imager** tool (you can simply choose from the list and it'll download from internet automatically).
- Insert memcard to raspberry pi and also plug ethernet cable to it to connect to router.
- Now see the local ip address from the router's wired devices section.
- Now you can simply connect to it by `ssh ubuntu@IP` and use password `ubuntu`, and then need to set up new password as prompted when you connect to server for the first time.
- You can copy your private key file by: `ssh-copy-id -i ~/.ssh/myKeys/april-2022 pi` where pi is my ssh alias(otherwise you can use ip address in its place). Also, you must specify the private key path in `IdentityFile` key for the ssh alias definition in `~/.ssh/config` file so it picks up the private key file auotmatically when you do `ssh pi` in future.

**Connecting wifi**

***FYI: There is an automated way of making the os connect to wifi automatically on the first start if you put your wifi SSID and password to the `network-config` [file as stated here in docs of mongodb](https://www.mongodb.com/developer/products/mongodb/mongodb-on-raspberry-pi/).***

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

**RESULT:** So, to fix that we need to run `ssh-keygen -R pi`, and after that it will work simply. Source: [Click here](https://stackoverflow.com/a/23150466/10012446)

## Installing mongodb

Official Guide of Install: [Click here](https://www.mongodb.com/developer/products/mongodb/mongodb-on-raspberry-pi/)

If you get below error,

```bash
ubuntu@ubuntu:~$ sudo apt update
Hit:1 http://ports.ubuntu.com/ubuntu-ports kinetic InRelease
Hit:2 http://ports.ubuntu.com/ubuntu-ports kinetic-updates InRelease
Ign:3 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 InRelease
Hit:4 http://ports.ubuntu.com/ubuntu-ports kinetic-backports InRelease
Hit:5 http://ports.ubuntu.com/ubuntu-ports kinetic-security InRelease
Hit:6 https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 Release
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
28 packages can be upgraded. Run 'apt list --upgradable' to see them.
W: https://repo.mongodb.org/apt/ubuntu/dists/focal/mongodb-org/4.4/Release.gpg: Key is stored in legacy trusted.gpg keyring (/etc/apt/trusted.gpg), see the DEPRECATION section in apt-key(8) for details.
```

you can fix it by running `cd /etc/apt; sudo cp trusted.gpg trusted.gpg.d`. Source: [Click here] And now you can run `sudo apt get update` successfully.


FYI: What actually worked for me to install mongodb is: Source: [Click here](https://www.mongodb.com/community/forums/t/installing-mongodb-over-ubuntu-22-04/159931)

```bash
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc |  gpg --dearmor | sudo tee /usr/share/keyrings/mongodb.gpg > /dev/null
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt update
sudo apt install mongodb-org

# ~sahil
# Ensure mongod config is picked up:
sudo systemctl daemon-reload

# Tell systemd to run mongod on reboot:
sudo systemctl enable mongod

# Start up mongod!
sudo systemctl start mongod
```

```
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc |  gpg --dearmor | sudo tee /usr/share/keyrings/mongodb.gpg > /dev/null
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list


# installing keys in old way
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

# removing
sudo rm /etc/apt/sources.list.d/mongodb-org-5.0.list
sudo rm /etc/apt/sources.list.d/mongodb-org-4.4.list
```

## install docker (a way to simply install mongodb using docker TESTING PHASE)

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo bash get-docker.sh
sudo usermod -aG docker $(whoami)


# for armv8 (i.e, my raspi with ubuntu 22 (jammy)), src: https://stackoverflow.com/a/72688644/10012446
sudo docker run -d -p 27017:27017 -v ~/data:/data/db --name mongo arm64v8/mongo

# for other processors
sudo docker run -d -p 27017:27017 -v ~/data:/data/db --name mongo mongo:bionic
```

## I must install 4.*? version on my arm64v8 processor now!

![image](https://user-images.githubusercontent.com/31458531/202874252-72f266a0-518f-4e26-9050-281a12f50854.png)

Source: [Click here](https://www.mongodb.com/docs/manual/release-notes/4.4)

![image](https://user-images.githubusercontent.com/31458531/202874380-59944495-c164-4d8d-921e-dad85f76454c.png)
