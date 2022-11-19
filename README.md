# Learn Raspberry

Some saved info about the device.

## Quick Links

- Official Article: Installing mongodb on 64 bit raspberry processor: [Click here ](https://www.mongodb.com/developer/products/mongodb/mongodb-on-raspberry-pi/)

## `armv7l` processor can only run 32 bit OS

Source: [Click here](https://askubuntu.com/questions/928227/is-armv7l-32-or-64-bit), Source2: [Click here](https://unix.stackexchange.com/questions/136407/is-my-linux-arm-32-or-64-bit)

### Is my running Linux kernel 32 bit or 64 bit?

```bash
getconf LONG_BIT
# Output: 32
````

### Cpu info

```bash
lscpu
# OUTPUT:
# Architecture:        armv7l
# Byte Order:          Little Endian
# CPU(s):              4
# On-line CPU(s) list: 0-3
# Thread(s) per core:  1
# Core(s) per socket:  4
# Socket(s):           1
# Vendor ID:           ARM
# Model:               3
# Model name:          Cortex-A72
# Stepping:            r0p3
# CPU max MHz:         1500.0000
# CPU min MHz:         600.0000
# BogoMIPS:            108.00
# Flags:               half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32
```

```bash
cat /proc/cpuinfo
# processor       : 0
# model name      : ARMv7 Processor rev 3 (v7l)
# BogoMIPS        : 108.00
# Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32
# CPU implementer : 0x41
# CPU architecture: 7
# CPU variant     : 0x0
# CPU part        : 0xd08
# CPU revision    : 3
# 
# processor       : 1
# model name      : ARMv7 Processor rev 3 (v7l)
# BogoMIPS        : 108.00
# Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32
# CPU implementer : 0x41
# CPU architecture: 7
# CPU variant     : 0x0
# CPU part        : 0xd08
# CPU revision    : 3
# 
# processor       : 2
# model name      : ARMv7 Processor rev 3 (v7l)
# BogoMIPS        : 108.00
# Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32
# CPU implementer : 0x41
# CPU architecture: 7
# CPU variant     : 0x0
# CPU part        : 0xd08
# CPU revision    : 3
# 
# processor       : 3
# model name      : ARMv7 Processor rev 3 (v7l)
# BogoMIPS        : 108.00
# Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32
# CPU implementer : 0x41
# CPU architecture: 7
# CPU variant     : 0x0
# CPU part        : 0xd08
# CPU revision    : 3
# 
# Hardware        : BCM2711
# Revision        : d03114
# Serial          : 10000000bed6ad56
# Model           : Raspberry Pi 4 Model B Rev 1.4
```
