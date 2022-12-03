# Install manjaro on rapsberry pi

Source: Go to Manjaro Downloads page on the ARM Section: [Click here](https://manjaro.org/download/)

![image](https://user-images.githubusercontent.com/31458531/205431670-0d164adc-8f69-4ec4-938e-05923fbc7767.png)

## Installation

I am donwloading the Manjaro Gnome Desktop becoz its sweet to use. Size of image is **1.1 GB** only. BUT YOU DON'T NEED TO DOWNLOAD IT FROM HERE THOGUH COZ *rpi imager** will do this for us automatically.

1. Open `rpi imager`, navigate to **CHOOSE OS > Other General Purpose OS > Manjaro ARM Linux > Manjaro ARM Gnome 22.10 (Size is 1.1 GB)** FYI: `Manjaro Minimal` version has no desktop environment.
2. Plug the memcard in raspberrypi and boot and connect to the display using your hdmi cable.
3. Installation process: Quick Video Reference: [Click here for hindi](https://www.youtube.com/watch?v=tx7gvBcr5A4), [Click here](https://youtu.be/ozAWczLqsB4)
4. TIMEZONE: Asia/Kolkata, Locale: en_IN, Keyboard Layout: us.

For installation you would need credentials like that:

```txt
# for real values, refer your keepass safe
username: SIMPLE_USER
full name: Bruno Mars
password: SIMPLY_DIGITS		(ALERT: i need to disable login to this user by ssh or by other computer for better security thogh)
root password: pi@**@pi
hostname: mars
```
