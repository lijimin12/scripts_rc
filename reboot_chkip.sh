#!/usr/bin/bash
# monitor ip addres change
# TODO: update IFNAME according to the host system 
# sudo apt install mailutils
# echo message | mail -s "subject" jimin.li@intel.com
# put this script under ~/bin/
# adding a entry in the crontab. crontab -l
# @reboot sleep 120 && date >> ~/bin/reboot_date.txt && ~/bin/reboot_chkip.sh

IFNAME=enp3s0

cd ~/bin

ip addr | /usr/bin/grep -w inet | /usr/bin/grep $IFNAME | awk '{print $2}' > new_ip_addr

diff old_ip_addr new_ip_addr

if [ $? -ne 0 ] ; then
    # ip addr changed
    changed=YES
    cp new_ip_addr old_ip_addr
else
    changed=NOT
fi

echo "sending email"
cat new_ip_addr | mail -s "$(hostname) IP address $changed changed over reboot $(LC_TIME=us_EN.UTF-8 date)" jimin.li@intel.com
