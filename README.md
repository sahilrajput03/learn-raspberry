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
- TODO: connect to wifi 
