#!/bin/bash

# For testing purposes only
echo "This is working"

# Using a gnome terminal to execute the following actions:
# Open a new terminal window and install build essential package
# Install guest additions via terminal: Download the ISO image
# Mount the ISO file
# Run the installer
# Reboot the VM

gnome-terminal -- bash -c "sudo apt-get update && sudo apt-get install -y build-essential dkms; \
wget http://download.virtualbox.org/virtualbox/6.1.16/VBoxGuestAdditions_6.1.16.iso -P /tmp; \
sudo mount -o loop /tmp/VBoxGuestAdditions_5.0.20.iso /mnt; \
sudo sh /mnt/VBoxLinuxAdditions.run; \
sudo reboot;" 


# Open a new terminal window and install build essential package
# sudo apt-get update && sudo apt-get install -y build-essential dkms

# Install guest additions via terminal 

# Download the ISO image
# wget http://download.virtualbox.org/virtualbox/6.1.16/VBoxGuestAdditions_6.1.16.iso -P /tmp

# Mount the ISO file
# sudo mount -o loop /tmp/VBoxGuestAdditions_5.0.20.iso /mnt

# Run the installer
# sudo sh /mnt/VBoxLinuxAdditions.run

# Reboot the VM
# sudo reboot

