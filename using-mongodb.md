# Install mongodb

## install mongodb's docker image

- Official Article: Installing mongodb on 64 bit raspberry processor: [Click here ](https://www.mongodb.com/developer/products/mongodb/mongodb-on-raspberry-pi/)
- Docker Installation: [Click here](https://github.com/sahilrajput03/learn-raspberry/#install-docker)
- Source: [Stackoverflow Answer](https://stackoverflow.com/a/72688644/10012446)
- Docker Hub: [arm64v8/mongo](https://hub.docker.com/r/arm64v8/mongo/)
- OS: Ubuntu jammy (LTS 22) armv8 Version

```bash
# run `arm64v8/mongo` image
sudo docker run -d -p 27017:27017 -v ~/data:/data/db --name mongo arm64v8/mongo:4.4.18

# OR: To run the docker container automatically when system is restarted. Source: https://docs.docker.com/config/containers/start-containers-automatically/
sudo docker run -d -p 27017:27017 -v ~/data:/data/db --name mongo --restart always arm64v8/mongo:4.4.18

## TESTING WITH AUTH ENABLED (DID NOT WORK COZ WE CAN"T CREATE CREDENTAILS FOR ADMIN NOW AT ALL)
## sudo docker run -d -p 27017:27017 -v ~/data:/data/db --name mongo --restart always arm64v8/mongo:4.4.18 --auth
## sudo docker run -d -p 27017:27017 -v ~/data:/data/db --name mongo --restart always -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=rootpassword arm64v8/mongo:4.4.18 --auth


## TESTING WITH CUSTOM CONFIG FILE
docker run --name mongo -v "$(pwd)"/etc/mongod.conf:/etc/mongo/mongod.conf -d --restart always arm64v8/mongo:4.4.18 --config /etc/mongo/mongod.conf

# you can attach to continer by
docker attach -it mongo bash
##### ##### ##### #####

# verify container details
docker ps -a

# start the stopped container (name=mongo becoz we set that earlier)
docker start mongo

# update container's restart policy
docker update --restart always mongo

# connecting to mongo db from remote pc
mongo 'YOUR-RPI-IP-ADDRESS'
mongo --host 'YOUR-RPI-IP-ADDRESS'
mongo mynotifyservice.ddns.net:27017
```

```bash
# DOCKER DB CREATION COMMAND
sudo docker run --name mongo -d -p 27017:27017 -v /home/ubuntu/mongo-with-docker/etc/mongo/mongod.conf:/etc/mongod.conf.orig -d --restart always -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=root arm64v8/mongo:4.4.18

# NOW BELOW COMMAND SHOULD BE HELP TO CONNECT
mongo -u "root" -p "root"

# CONNECTION COMMAND
# mongo -u "root" -p "root" --host 192.168.18.13
# mongodb://root:root@192.168.18.13:27017/
```

```js

// USING MONGO SHELL TO CREATING USER with (username,password)=(sahil,lihas)
// *NOTE*: Switching to admin database is *NECESSARY* becoz only then we can create user. Source: https://stackoverflow.com/a/65266251/10012446
use admin
// Use createUser function to create user with given roles
db.createUser(
	{
		user: "sahil",
		pwd: "lihas",
		roles: [ "userAdminAnyDatabase", "dbAdminAnyDatabase", "readWriteAnyDatabase"]
	}
)


// SHOW CURRENT USER INFORMATION IN MONGO SHELL
db.runCommand({connectionStatus : 1})


// REMOVE USER
db.removeUser("UsernName")


// EXIT SHELL
exit
```

*Fyi:(\*not tested yet\*) You can also use Ubuntu Bionic - LTS 18.04 image as well by using `sudo docker run -d -p 27017:27017 -v ~/data:/data/db --name mongo mongo:bionic`.*


## Securing and user management with mongodb

The three roles listed give the `admin` user the ability to administer all user accounts and data in MongoDB. Make sure your password is secure.

```bash
use admin
db.createUser(
	{
		user: "admin",
		pwd: "pi@01iiadnuyh@pi",
		roles: [ "userAdminAnyDatabase", "dbAdminAnyDatabase", "readWriteAnyDatabase"]
	}
)
exit

```


## Why I must install 4.* only (and NOT version 5.x or 6.x of mongodb)?

Because version on my arm64v8 processor now coz 5.* and above are not supported currently. **So I am using tag 4.4.18 <which is most recent supported version for arm64v8 processors>.**

![image](https://user-images.githubusercontent.com/31458531/202874252-72f266a0-518f-4e26-9050-281a12f50854.png)

- **MongoDB 4.4.18 Released on November 15, 2022**: [Click here](https://www.mongodb.com/docs/manual/release-notes/4.4)


## `TODO Remove: this section after Jan 31, 2023` Installing mongodb on host systmem (NOT RECOMMENDED)

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
