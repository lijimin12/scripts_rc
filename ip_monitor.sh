#!/usr/bin/bash
# monitor ip addres change

cd ~/bin

# !!! need to change per platform
HOST="SPR"
IF=enx000ec6c2b800

ip addr | /usr/bin/grep -w inet | /usr/bin/grep ${IF} | awk '{print $2}' > new_ip_addr

diff old_ip_addr new_ip_addr

if [ $? -ne 0 ] ; then
    echo "sending email"
	# note: mail tool needs to be installed with 'sudo apt install mailutils'
    # -s subject
    cat new_ip_addr | mail -s ${HOST}" IP address changed over reboot" jimin.li@intel.com
    cp new_ip_addr old_ip_addr
else
    cat new_ip_addr | mail -s ${HOST}" IP address NOT changed over reboot" jimin.li@intel.com
fi
