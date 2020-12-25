#!/bin/sh

# Replacing the contents of the /etc/gdm3/custom.conf file to enable autologin since this cannot be set during unattended install
sudo sed -i.bu -e 's/# AutomaticLoginEnable = true/AutomaticLoginEnable = true/' -e 's/# AutomaticLogin = user1/AutomaticLogin = kush/' /etc/gdm3/custom.conf

# Restart 
sudo reboot
