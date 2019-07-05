#!/bin/bash

# add  user using password

username=$1
user="$username"
passwd="${username}!@@#@!#&*&%"
useradd -m -s /bin/bash ${user}
echo "${user}:${passwd}" | chpasswd
[ -d /etc/sudoers.d ] && echo "${username}     ALL=(ALL)     NOPASSWD: ALL" > /etc/sudoers.d/user_${username} || echo "${username}    ALL=(ALL)     NOPASSWD: ALL" >> /etc/sudoers
[ -f /etc/sudoers.d/user_${username} ] && chmod 440 /etc/sudoers.d/user_${username}
sed -i '/allowusers/d' /etc/ssh/sshd_config && /etc/init.d/ssh restart
sed -i "/${user}/s/\/usr\/sbin\/nologin/\/bin\/bash/1" /etc/passwd
rm -f /etc/cron.d/puppet_sync

# add user using key

DIR="/home/${username}/.ssh"
FILE="${DIR}/authorized_keys"

[ ! -d ${DIR} ] && mkdir -p ${DIR}
chown ${username}:${username} ${DIR}
chown ${username}:${username} /home/${username}
chmod 700 ${DIR}

wget -qO ${FILE} http://1.1.1.100:8080/conf/authorized_keys_${username}
chown ${username}:${username} ${FILE}
chmod 600 ${FILE}
