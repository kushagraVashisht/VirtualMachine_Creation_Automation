#!/bin/sh

# Get root access
su root 

# Change the language settings to get rid of the bugs
sed -i -e 's/LANG=en_US/LANG=en_US.UTF-8/g' /etc/default/locale

# Replacing the contents of the /etc/gdm3/custom.conf file to enable autologin since this cannot be set during unattended install
# sed -i.bu -e 's/# AutomaticLoginEnable = true/AutomaticLoginEnable = true/' -e 's/# AutomaticLogin = user1/AutomaticLogin = kush/' /etc/gdm3/custom.conf

# Restart 
reboot
