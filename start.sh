service start netfs &
sleep 2
service samba start &
sleep 2
mount /mnt/s3fs-data
echo "echo ctl+P Q to background this container" > initfile
echo "smbpasswd -a storageuser" >> initfile
/bin/bash --init-file initfile


