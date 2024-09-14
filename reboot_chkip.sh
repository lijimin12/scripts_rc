#!/usr/bin/bash
# monitor ip addres change
# NOTE: 
# 1. this script is already in my github, don't make local change
# 2. for option#1, update IFNAME according to the host system
# Steps:
# 1. `sudo apt install mailutils`, and then send a trial email: echo hello | mail -s "subject" jimin.li@intel.com
# 2. put this script under ~/bin/ (mkdir ~/bin if needed) and chmod +x to make it executable
# 3. adding an entry in the crontab. crontab -l
# MAILTO=""
# @reboot sleep 120 && date >> ~/bin/reboot_date.txt && ~/bin/reboot_chkip.sh

cd ~/bin

# option#1
# IFNAME=enp3s0
# ip addr | /usr/bin/grep -w inet | /usr/bin/grep $IFNAME | awk '{print $2}' > new_ip_addr
# option#2:
ip addr | /usr/bin/grep -o "\<10\.[0-9]*\.[0-9]*\.[0-9]*/[0-9]*" > new_ip_addr
# ip addr | /usr/bin/grep -w inet| /usr/bin/grep -o "\<10\.[0-9]*\.[0-9]*\.[0-9]*/[0-9]*" > new_ip_addr
# NOTE: on this alternative option,
# 1. an assumption, the ip address starts with 10.
# 2. benefit is that no need to edit IFNAME manually

diff old_ip_addr new_ip_addr

if [ $? -ne 0 ] ; then
    # ip addr changed
    changed=YES
    cp new_ip_addr old_ip_addr
else
    changed=NOT
fi

echo "sending email"
cat new_ip_addr | mail -s "$(hostname) IP address $changed changed over reboot $(LC_TIME=us_EN.UTF-8 date) - $0" jimin.li@intel.com
