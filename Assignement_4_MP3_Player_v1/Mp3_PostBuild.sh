#!/bin/bash

if [ ! `cat ${BINARIES_DIR}/rpi-firmware/config.txt | grep "dtparam=audio=on"` ]; then 

    echo "#Enable soundcard" >> ${BINARIES_DIR}/rpi-firmware/config.txt
    echo "dtparam=audio=on"  >> ${BINARIES_DIR}/rpi-firmware/config.txt
fi

if [ ! `cat ${BINARIES_DIR}/rpi-firmware/config.txt | grep "uart_enable=1"` ]; then 
 
    echo "#Enable Serial at boot time" >> ${BINARIES_DIR}/rpi-firmware/config.txt
    echo "uart_enable=1" 	       >> ${BINARIES_DIR}/rpi-firmware/config.txt
fi

echo "# Authentication:"   >>  ${TARGET_DIR}/etc/ssh/sshd_config
echo "PermitRootLogin yes" >>  ${TARGET_DIR}/etc/ssh/sshd_config


chmod 777 ${TARGET_DIR}/etc/init.d/S11AutoMount
chmod 777 ${TARGET_DIR}/etc/init.d/S224pulseaudio
chmod 777 ${TARGET_DIR}/etc/init.d/S33MainDemon
chmod 777 ${TARGET_DIR}/MP3/automount.sh
chmod 777 ${TARGET_DIR}/MP3/MainScript.sh
chmod 777 ${TARGET_DIR}/MP3/InitScript.sh
