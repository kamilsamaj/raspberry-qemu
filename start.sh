#!/bin/bash
# create a tap nic
if ! ip a show tap0 &>/dev/null; then
    sudo ip tuntap add dev tap0 mode tap
    sudo ip link set tap0 up promisc on
    sudo ip link set dev virbr0 up
    sudo ip link set dev tap0 master virbr0
fi

qemu-system-arm \
  -M versatilepb \
  -cpu arm1176 \
  -m 256 \
  -device "virtio-blk-pci,drive=disk0,disable-modern=on,disable-legacy=off" \
  -drive "file=2020-02-13-raspbian-buster.qcow2,if=none,index=0,media=disk,id=disk0,format=qcow2" \
  -dtb versatile-pb-buster-5.4.51.dtb \
  -kernel kernel-qemu-5.4.51-buster \
  -append 'root=/dev/vda2 panic=1' \
  -no-reboot \
  -net nic \
  -net "user,hostfwd=tcp::5022-:22" \
  -net "tap,ifname=tap0,script=no,downscript=no"
