#!/bin/bash

# Asking the user if they have downloaded the ISO and if not, if they would like to download one before the script starts
read -p "Have you downloaded the Ubuntu ISO image? [yn]" answer
if [[ $answer = y ]] ; then
  echo "Already have the ISO downloaded. Continue with the script"
elif [[ $answer = n ]]; then
  read -p "Do you wish to download the ISO from the internet? [yn]" answer
  if [[ $answer = y ]] ; then
    wget -c "https://releases.ubuntu.com/20.04/ubuntu-20.04.1-desktop-amd64.iso"
  else
    echo "Please install the ISO image first, then start with the installation again"
    exit
  fi
fi

# Creating a VM and registering it 
VBoxManage createvm --name Test1_Linux_VM --ostype Ubuntu_64 --register

# Setting systembase memory to the VM (2048MB), RAM (8GB) and VirtualCPUs (2).
# Setting Shared Clipboard and Drag n Drop to bidirectional
# Disabling Audio, USB, USB2.0, USB3.0 since there's no need for them
VBoxManage modifyvm Test1_Linux_VM --memory 2048 --vram 8 --cpus 2 --audio none --usb off --usbehci off --usbxhci off --clipboard-mode bidirectional --draganddrop bidirectional

# Create Virtual Hard Disk of size 10GB (recommended) and of format VDI
VBoxManage createhd --filename VirtualBox\ VMs/Test1_Linux_VM/Test1_Linux_VM.vdi --size 10000 --format VDI

# Creating a SATA controller which we will attach the virtual disk to
VBoxManage storagectl Test1_Linux_VM --name "SATA Controller" --add sata --controller IntelAhci

# Attaching the virtual disk to the SATA controller
VBoxManage storageattach Test1_Linux_VM --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium VirtualBox\ VMs/Test1_Linux_VM/Test1_Linux_VM.vdi

# Adding the IDE controller since we're creating a fresh VM from ISO image
VBoxManage storagectl Test1_Linux_VM --name "IDE Controller" --add ide --controller PIIX4

# Attach the ISO image to IDE controller (Ubuntu 20.04.1)
VBoxManage storageattach Test1_Linux_VM --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium <Full path to the location of the ISO file>

# Unattended installation and start VM
VBoxManage unattended install Test1_Linux_VM --user=<username> --password=<password, without quotes> --country=AU --time-zone=AEDT --iso=<Full path to the location of the ISO file> --start-vm=gui

# Starting the VM (No Need for this bit, still testing out things)
# VBoxManage startvm Test1_Linux_VM
