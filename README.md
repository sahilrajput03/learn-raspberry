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
- Connecting to wifi: Install `nmtui` by command: `sudo apt install network-manager`.
- Now we enter password via the menu we see with `nmtui` program, its fun though and connect to wifi.
- Now we can remove the ethernet cable and just see the ip address the device gets from the same router's device page under `Wi-Fi devices` this time.
- Now we copy that `ip address` and use username as `ubuntu` and use that in our ~/.ssh/config file (by replacing old ip address which belonged to wired connnection).
- Now when you try to connect say by `ssh pi` we see some error like:

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

So, to fix that we need to run `ssh-keygen -R pi`, and after that it will work simply. Source: [Click here](https://stackoverflow.com/a/23150466/10012446)
