# raspberry-qemu
QEMU start scripts for a Raspbian VM

# Get the OS image
* Download a zip file with the OS image https://www.raspberrypi.org/software/operating-systems/
```
sudo apt-get install qemu-utils qemu-system-arm unzip
unzip <raspbian-image>.zip
qemu-img convert -f raw -O qcow2 <raspbian-image>.img <raspbian-image>.qcow2
qemu-img resize <raspbian-image>.qcow2 +20G


# Start the image
```
./start.sh
```
