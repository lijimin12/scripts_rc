#!/usr/bin/bash
# reboot.sh 应该有新的版本
# 不能做到通用，网卡名称，邮箱地址要手工调整
# 机器重启后，检查IP地址是否有变化，并发送邮件进行通知

#!/usr/bin/bash
# intended to run on server
# when server restarts up, send mail to myslef telling the new ip address

set -x
set -e

# todo:
# capture exti w/ error, can echo failed >> reboot_date.txt

cd ~
# clear old logs
date > reboot_date.txt
id -un >> reboot_date.txt

# fail
# echo ${PATH} >> reboot_date.txt
# fail /usr/bin/which ifconfig >> reboot_date.txt


echo "sudo ifconfig..." >> reboot_date.txt
sudo ifconfig >> reboot_date.txt
echo "ifconfig done" >> reboot_date.txt

echo "sudo ifconfig enp1s0 down" >> reboot_date.txt
sudo ifconfig enp1s0 down
sleep 5

echo "sudo ifconfig enp1s0 hw ether ..." >> reboot_date.txt
sudo ifconfig enp1s0 hw ether "98:4f:ee:00:72:3f"
sleep 5

echo "sudo systemctl restart NetworkManager" >> reboot_date.txt
sudo systemctl restart NetworkManager
sleep 10

echo "sudo ifconfig enp1s0 up" >> reboot_date.txt
sudo ifconfig enp1s0 up
sleep 10

echo "sudo ifconfig enp1s0" >> reboot_date.txt
sudo ifconfig enp1s0 >> reboot_date.txt

# send email
set +e
sudo systemctl status postfix.service >> reboot_date.txt || true
sudo systemctl start postfix.service
sleep 10
sudo systemctl status postfix.service >> reboot_date.txt

enp=enp1s0
sudo ip addr | /usr/bin/grep inet | /usr/bin/grep $enp | awk '{print $2}' > new_ip_addr
diff old_ip_addr new_ip_addr

if [ $? -ne 0 ] ; then
    #echo "sending email"
    # -s subject
    cat new_ip_addr | mail -s "SPR IP address changed over reboot" jimin.li@intel.com
    cp new_ip_addr old_ip_addr
else
    cat new_ip_addr | mail -s "SPR IP address NOT changed over reboot" jimin.li@intel.com
fi
```

**lgg**
In .bahsrc,
```bash
# linux kernel grep
lgg() {
    if [ ${1} = '?' ]; then
        echo "linux kernel source codes grep"
        echo "run it at the root of linux kernel source codes tree"
        echo "usage: on linux kernel source codes root folder, lgg pattern_string "
        return
    fi
    if [[ $(basename `pwd`) =~ .*inux|INUX|ernel|ERNEL.* ]]; then
        echo "in kernel source code root, go ahead"
    else
        echo "not in root kernel source code, exit"
        return
    fi
    grep -nr --include="*.c" --include="*.S" --include="*.h" --exclude-dir="sound" --exclude-dir="fs" --exclude-dir="Documentation" --exclude-dir="arch" ${1} . ./arch/x86
}
