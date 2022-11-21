# Install mongodb

TODO:
- [ MongoDB 5 ] Backup & Restore MongoDB database: [Click here](https://www.youtube.com/watch?v=AsNeE_95QBA)
- [ MongoDB 6 ] How to Deploy a MongoDB ReplicaSet: [Click here](https://www.youtube.com/watch?v=Q2lJH156SUQ)

## install mongodb's docker image

- Official Article: Installing mongodb on 64 bit raspberry processor: [Click here ](https://www.mongodb.com/developer/products/mongodb/mongodb-on-raspberry-pi/)
- Official Article: Mongodb Authentication: [Click here](https://www.mongodb.com/features/mongodb-authentication)
	- Docs - User Defined Roles: [Click here](https://www.mongodb.com/docs/manual/core/security-user-defined-roles/#std-label-user-defined-roles)
	- `db.createRole()` : [Click here](https://www.mongodb.com/docs/manual/reference/method/db.createRole/#mongodb-method-db.createRole)
	- Builtin Roles: [Click here](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-userAdmin)
- Docker Installation: [Click here](https://github.com/sahilrajput03/learn-raspberry/#install-docker)
- Source: [Stackoverflow Answer](https://stackoverflow.com/a/72688644/10012446)
- Docker Hub: [arm64v8/mongo](https://hub.docker.com/r/arm64v8/mongo/)
- OS: Ubuntu jammy (LTS 22) armv8 Version

```bash
# run `arm64v8/mongo` image
sudo docker run -d -p 27017:27017 -v ~/data:/data/db --name mongo arm64v8/mongo:4.4.18

# OR: To run the docker container automatically when system is restarted. Source: https://docs.docker.com/config/containers/start-containers-automatically/
sudo docker run -d -p 27017:27017 -v ~/data:/data/db --name mongo --restart always arm64v8/mongo:4.4.18

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
mongo 'YOUR-RPI-IP-ADDRESS' // database is `test` by default
mongo 'YOUR-RPI-IP-ADDRESS/dbName'
mongo --host 'YOUR-RPI-IP-ADDRESS'
mongo mynotifyservice.ddns.net:27017
```

```bash

# MAKE SURE YOU HAVE `data` directory in current folder as we are linking it as volume

# DOCKER DB CREATION COMMAND (with config file, I didn't test the config file working though but it should work IMO ~sahil)
sudo docker run --name mongo -d -p 27017:27017 -v data:/data/db -v /home/ubuntu/mongo-with-docker/etc/mongo/mongod.conf:/etc/mongod.conf.orig -d --restart always -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=root arm64v8/mongo:4.4.18
# DOCKER DB CREATION COMMAND (CURRENT WORKS)
sudo docker run --name mongo -d -p 27017:27017 -v ~/data:/data/db -d --restart always -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=root arm64v8/mongo:4.4.18


# NOW BELOW COMMAND SHOULD BE HELP TO CONNECT
mongo -u "root" -p "root"
# CONNECT TO TARGET HOST WITH USER AUTHENTICATION, default database is `admin`. So, user in `admin` database
mongo -u "root" -p "root" 192.168.18.13
# Same as above but connect to admin database (You can always change database inside shell via `use dbName` as well)
mongo -u root -p root 192.168.18.13/admin

# WHEN YOU WANT TO ENTER PASSWORD IN A SECURE PROMPT
mongo -u "root" -p
# WHEN YOU WANT TO LOGIN WITH A USER CREATED IN OTHER THAN `admin` DATABSE, for e.g., in `car` database
mongo -u "root" -p "root" 192.168.18.13/car --authenticationDatabase test
# USING CONNECTION STRING
mongo mongodb://root:root@192.168.18.13:27017/

# MANUAL LOGIN IN MONGO SHELL
# STEP1: connect to mongo shell first
mongo
# STEP2: Now in shell you can authenticate by:
use admin // change to admin DB
db.auth('root', 'root')
```

- `db.createUser()` API: [Click here](https://www.mongodb.com/docs/manual/reference/method/db.createUser/)
- User Authentication in mongodb: Source - [ MongoDB 4 ] Configuring authentication, users and roles in MongoDB: [Youtube](https://www.youtube.com/watch?v=SY_9zwb29LA)

**The three roles listed give the `admin` user the ability to administer all user accounts and data in MongoDB. Make sure your password is secure.**


```js
// CREATING A USER IN `admin` DB USING MONGO SHELL (username,password)=(sahil,lihas)

// Get selected db (Expected Ouput: `admin` if you specify database name while connecting to mongodb server)
db

// *NOTE*: Switching to admin database is *NECESSARY* becoz only then we can create user. Source: https://stackoverflow.com/a/65266251/10012446

// Use createUser function to create admin user with given roles to admin DATABASE
use admin
db.createUser(
	{
		user: "admin",
		pwd: "admin",
		roles: [ "userAdminAnyDatabase", "dbAdminAnyDatabase", "readWriteAnyDatabase"]
	}
)

// ADD A ADMIN PRIVILIDGED USER `sahil` to admin DATABASE
use admin
db.createUser(
	{
		user: "sahil",
		pwd: "sahil",
		roles: [ "userAdminAnyDatabase", "dbAdminAnyDatabase", "readWriteAnyDatabase"] // creating master user by using such roles
	})


// ADD A GLOBAL USER TO HAVE READ/WRITE ACCESS TO DATABASE DB1 AND DB2. (GLOBAL as we are adding this user to the admin database itself)
use admin
db.createUser(
	{
		user: "mohit",
		pwd: "mohit",
		roles: [
			{ role: "readWrite", db: "db1" }, // providing readWrite access to db1
			{ role: "readWrite", db: "db2" }  // providing readWrite access to db2
		]
	}
)

// Creating user in particular database i.e, car and assigning read/write access to it by giving `readWrite` role
use car
db.createUser(
	{
		user: "tokyo",
		pwd: "tokyo",
		roles: [ "readWrite" ]
	}
)
// CONNECTO USING MONGO SHELL: mongo -u tokyo -p tokyo 192.168.18.13/car --authenticationDatabase car
// CONNECTION STRING MongoDB COMPASS: mongodb://tokyo:tokyo@192.168.18.13:27017/car?authSource=car


// INSERT DOCUMENT TO car DATABASE
use car
db.bar.insert({name: "Sahil Rajput"})

// CHANGE PASSWORD FOR A USER
db.changeUserPassword('sahil', 'sahil')

// LEARN: Each database has its own roles

// SHOW USERS and ROLES
use admin // change to admin DB
// Get available roles for currently selected database i.e, admin
show roles
// Get users for currently selected database i.e, admin
show users
db.getUsers() // same as above
db.runCommand({connectionStatus : 1}) // same as above


// REMOVE USER
db.dropUser("UsernName") // previously: db.removeUser("UsernName")


// EXIT SHELL
exit
```

**Also, non authenticated users would see such error when trying to insert documents:**

![image](https://user-images.githubusercontent.com/31458531/202909615-fea3765e-bd35-4cf2-89e8-93712aa3d696.png)

**Roles**

- `dbAdmin`: Provides the ability to perform administrative tasks such as schema-related tasks, indexing, and gathering statistics. This role does not grant privileges for user and role management. Read more: https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-dbAdmin
- `readWrite`: Provides all the privileges of the read role plus ability to modify data on all non-system collections and the system.js collection.
- `userAdmin`: Provides the ability to create and modify roles and users on the current database. Since the userAdmin role allows users to grant any privilege to any user, including themselves, the role also indirectly provides superuser access to either the database or, if scoped to the admin database, the cluster.
- `dbOwner`: ( `dbOwner` = `dbAdmin` + `readWrite` + `userAdmin`): The database owner can perform any administrative action on the database. This role combines the privileges granted by the readWrite , dbAdmin and userAdmin roles. WARNING: It is important to understand the security implications of granting the userAdmin role: a user with this role for a database can assign themselves any privilege on that database. Granting the userAdmin role on the admin database has further security implications as this indirectly provides superuser access to a cluster. With admin scope a user with the userAdmin role can grant cluster-wide roles or privileges including userAdminAnyDatabase.
- `read`: Provides the ability to read data on all non-system collections and the system.js collection. 

**The `userAdmin` role explicitly provides the following actions:**
- `changeCustomData`, `changePassword`, `createRole`, `createUser`, `dropRole`, `dropUser`, `grantRole`, `revokeRole`, `setAuthenticationRestriction`, `viewRole` and `viewUser` role.


*Fyi:(\*not tested yet\*) You can also use Ubuntu Bionic - LTS 18.04 image as well by using `sudo docker run -d -p 27017:27017 -v ~/data:/data/db --name mongo mongo:bionic`.*


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
