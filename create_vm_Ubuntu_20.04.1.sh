#!/bin/bash

# Creating a VM and registering it 
VBoxManage createvm --name Test1_Linux_VM --ostype Linux26_64 --register

# Setting systembase memory to the VM (2048MB)
VBoxManage modifyvm Test1_Linux_VM --memory 2048

# Create Virtual Hard Disk of size 10GB (recommended) and of format VDI
VBoxManage createhd --filename VirtualBox\ VMs/Test1_Linux_VM/Test1_Linux_VM.vdi --size 10000 --format VDI

# Creating a SATA controller which we will attach the virtual disk to
VBoxManage storagectl Test1_Linux_VM --name "SATA Controller" --add sata --controller IntelAhci

# Attaching the virtual disk to the SATA controller
VBoxManage storageattach Test1_Linux_VM --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium VirtualBox\ VMs/Test1_Linux_VM/Test1_Linux_VM.vdi

# Adding the IDE controller since we're creating a fresh VM from ISO image
VBoxManage storagectl Test1_Linux_VM --name "IDE Controller" --add ide --controller PIIX4

# Attach the ISO image to IDE controller (Ubuntu 20.04.1)
VBoxManage storageattach Test1_Linux_VM --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium <Location of the ISO file> 

# Starting the VM
VBoxManage startvm Test1_Linux_VM
