# Install mongodb

## install mongodb's docker image

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo bash get-docker.sh
sudo usermod -aG docker $(whoami)


# `mongod` Docker hub page: https://hub.docker.com/r/arm64v8/mongo/
# For armv8 (i.e, my raspi with ubuntu 22 (jammy)), src: https://stackoverflow.com/a/72688644/10012446
# (Latest version not supported so I am using tag 4.4.18 <which is most recent supported version for arm64v8 processors>)sudo docker run -d -p 27017:27017 -v ~/data:/data/db --name mongo arm64v8/mongo
# Below works for my case, yo!! PARTY
sudo docker run -d -p 27017:27017 -v ~/data:/data/db --name mongo arm64v8/mongo:4.4.18
# check container details
docker ps

# for other processors
sudo docker run -d -p 27017:27017 -v ~/data:/data/db --name mongo mongo:bionic
```

## Why I must install 4.* only (and NOT version 5.x or 6.x of mongodb)?

Because version on my arm64v8 processor now coz 5.* and above are not supported currently

![image](https://user-images.githubusercontent.com/31458531/202874252-72f266a0-518f-4e26-9050-281a12f50854.png)

- **MongoDB 4.4.18 Released on November 15, 2022**: [Click here](https://www.mongodb.com/docs/manual/release-notes/4.4)


## Installing mongodb on host systmem (NOT RECOMMENDED)

Notice the guid has both `focal` and `jammy` installation instructions below.

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
# for ubuntu lts 20 i.e, `ubuntu focal` (fyi: I am using lts 22 i.e, `ubuntu jammy`)
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

- Installing 4.4 key and repository to `ubuntu jammy`

```bash
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc |  gpg --dearmor | sudo tee /usr/share/keyrings/mongodb.gpg > /dev/null
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list


# installing keys in old way
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

# removinng repository list from `ubuntu jammy`
sudo rm /etc/apt/sources.list.d/mongodb-org-5.0.list
sudo rm /etc/apt/sources.list.d/mongodb-org-4.4.list
```