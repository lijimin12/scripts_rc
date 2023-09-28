#!/usr/bin/bash
# monitor possible host ip addres change over reboot
# should be put in ~/.ip_monitro.sh
# dont want to be seen, script and ip address files are hidden files intendedly
# @reboot sleep 60 && ~/.ip_monitor.sh
# crontab -e ; crontab -l
# deprecated: @reboot sleep 60 && date >> ~/bin/reboot_date.txt && ~/bin/ip_monitor.sh

# cd ~/bin
set -x
# set -e
# !!! need to change per platform
IF=enx000ec6c2b800

#HOST="SPR"
HOST=$(hostname)

cd ~
old_ip_addr=".ip_addr.old"
new_ip_addr=".ip_addr.new"
touch $new_ip_addr
touch $old_ip_addr

ip addr | /usr/bin/grep -w inet | /usr/bin/grep ${IF} | awk '{print $2}' > $new_ip_addr

set +e
diff $old_ip_addr $new_ip_addr

if [ $? -ne 0 ] ; then
    echo "sending email"
        # note: mail tool needs to be installed with 'sudo apt install mailutils'
    # -s subject
	# 'LC_TIME=zh_CN.UTF-8' mail failed
    cat $new_ip_addr | mail -s ${HOST}" IP address changed over reboot $(LC_TIME=us_EN.UTF-8 date)" jimin.li@intel.com
    cp $new_ip_addr $old_ip_addr
else
    echo "sending NOT CHANGE email"
    cat $new_ip_addr | mail -s ${HOST}" IP address NOT changed over reboot $(LC_TIME=us_EN.UTF-8 date)" jimin.li@intel.com
fi
