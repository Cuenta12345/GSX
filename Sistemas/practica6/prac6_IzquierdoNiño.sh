#! /bin/bash

dd if=/dev/zero of=/var/swap bs=4096k count=16

mount -o loop memtest86-usb.img /mnt