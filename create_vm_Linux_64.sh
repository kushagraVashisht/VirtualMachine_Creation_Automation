#!/bin/bash

# Get root access
su root 

# Mount the image to make the necessary changes  
mount -o loop /Users/kushagravashisht/Desktop/PROJECTS/ISO/working/ubuntu-18.04.5-desktop-amd64.iso /Users/kushagravashisht/Desktop/PROJECTS/ISO/working/image-mount 

# Add the pre-install script to deal with the identified bugs (Terminal not starting and autologin not working)
chmod +x $(dirname $0)/post_install_autologin.sh
cp $(dirname $0)/post_install_autologin.sh image-mount/etc/init.d

# Unmount the image to make the necessary changes  
umount image-mount

# Asking the user if they have downloaded the ISO and if not, if they would like to download one before the script starts
read -p "Have you downloaded the Ubuntu ISO image? [y/n] " answer
if [[ $answer = y ]] ; then
  echo "Already have the ISO downloaded. Continue with the script"
elif [[ $answer = n ]]; then
  read -p "Do you wish to download the ISO from the internet? [y/n] " answer
  if [[ $answer = y ]] ; then
    wget -c "https://releases.ubuntu.com/20.04/ubuntu-20.04.4-desktop-amd64.iso"
  else
    echo "Please install the ISO image first, then start with the installation again"
    exit
  fi
fi

# Creating a VM and registering it 
VBoxManage createvm --name Test1_Linux_VM --ostype Ubuntu_64 --register
# VBoxManage createvm --name Test1_Linux_VM --ostype Linux --register

# Create a storage medium once the VM has been registered
VBoxManage createmedium --filename /Users/kushagravashisht/VirtualBox\ VMs/Test1_Linux_VM/Test1_Linux_VM.vdi --size 10240

# Creating a SATA controller which we will attach the virtual disk to
VBoxManage storagectl Test1_Linux_VM --name SATA --add SATA --controller IntelAhci

# Attaching the virtual disk to the SATA controller
VBoxManage storageattach Test1_Linux_VM --storagectl SATA --port 0 --device 0 --type hdd --medium /Users/kushagravashisht/VirtualBox\ VMs/Test1_Linux_VM/Test1_Linux_VM.vdi

# Additions: systembase memory (2048MB), RAM (8GB), VirtualCPUs (2), Graphics Controller (vmsvga), Mouse (usbtablet), IOAPIC (on), Shared Clipboard (bidirectional), Drag n Drop (bidirectional)
# Disabled: Audio, USB, USB2.0, USB3.0, Pae, accelerate3d
# **IOAPIC: Allows the OS to use more than 16 interrupt requests(IRQs)
VBoxManage modifyvm Test1_Linux_VM --memory 4096 --vram 16 --cpus 2 --graphicscontroller vmsvga --ioapic on --mouse usbtablet --clipboard-mode bidirectional --draganddrop bidirectional
VBoxManage modifyvm Test1_Linux_VM --audio none --pae off --usb off --usbehci off --usbxhci off --accelerate3d off

# Defining the network settings for the VM (Uncomment if you wish to use)
# VBoxManage modifyvm ubuntu18server --nic1 bridged --bridgeadapter1 wlan0 --nic2 nat

# Unattended installation and start VM
# VBoxManage unattended install Test1_Linux_VM --user=kush --password=Sample@123 --country=AU --time-zone=AEDT --iso=/Users/kushagravashisht/Desktop/PROJECTS/ISO/working/ubuntu-18.04.5-desktop-amd64.iso --install-additions --post-install-template post_install_autologin.sh --start-vm=gui
VBoxManage unattended install Test1_Linux_VM --user=kush --password=Sample@123 --country=AU --time-zone=AEST --iso=/Users/kushagravashisht/Desktop/PROJECTS/ISO/working/image-mount --install-additions --start-vm=gui

# VBoxManage unattended install Test1_Linux_VM --user=kush --password=Sample@123 --country=AU --time-zone=AEDT --iso=/Users/kushagravashisht/Desktop/PROJECTS/ISO/backup/linuxmint-20.1-cinnamon-64bit.iso --install-additions  --start-vm=gui
