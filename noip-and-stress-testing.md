# noip

## Some useful commands

```bash
top
stress -c 8
```

## noip2

Dynamic update client [docs here](https://my.noip.com/dynamic-dns/duc)

noip2 -S                #Shows status: *Use sudo to run command in root mode
                        # coz first time after creating a configuration it
                        # doesn't without sudo prefixed, yikes!

noip2                   # Runs noip2 service.
noip2 -h                # Shows help from noip2
noip2 -K 702            # Delete an existing configuration running task.
sudo noip2 -C           # Use this command to create a new config after terminating a existing running process.

**IMPORTANT After installation noip2** give read permission to the configuration file to all the users by below command,
and the `.profile` file would be able to run use the configuration without any
silly error, yikes!!

`sudo chmod +rwx /usr/local/etc/no-ip2.conf`
