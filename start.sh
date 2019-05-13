echo "$AWSKEY:$AWSSECRET" >> /etc/passwd-s3fs
chmod 600 /etc/passwd-s3fs
echo "s3fs#$BUCKET /mnt/s3fs-data fuse storage_class=reduced_redundancy,allow_other,rw,umask=000,use_cache=/mnt/s3fs-tmp 0 0" > etc/fstab
useradd -ms /bin/bash $SMBUSER
mkdir /mnt/s3fs-data; 
mkdir /mnt/s3fs-tmp; 
chmod -R 777 /mnt/s3fs-tmp; 
chown -R $SMBUSER /mnt/s3fs-data
(echo $SMBPASS; echo $SMBPASS) | smbpasswd -a -s $SMBUSER
echo "$SMBUSER" >> /etc/samba/smb.conf
mount /mnt/s3fs-data
service smbd start
tail -f /dev/null


