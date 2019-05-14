echo "$AWSKEY:$AWSSECRET" >> /etc/passwd-s3fs
chmod 600 /etc/passwd-s3fs
useradd -ms /bin/bash $SMBUSER
(echo $SMBPASS; echo $SMBPASS) | smbpasswd -a -s $SMBUSER
echo "" > /etc/samba/smb.conf

echo Buckets are $BUCKET
for B in $BUCKET; do
	echo "Configuring folders for $B"
	mkdir /mnt/s3fs-$B; 
	mkdir /mnt/s3fs-$B-tmp; 
	chmod -R 777 /mnt/s3fs-$B-tmp; 
	chown -R $SMBUSER /mnt/s3fs-$B
	sed "s/_BUCKET_/$B/g" /etc/samba/smb.conf.template >> /etc/samba/smb.conf
done

echo "$SMBUSER" >> /etc/samba/smb.conf
service smbd start

for B in $BUCKET; do
	echo "Starting s3fs for $B"
	s3fs $B /mnt/s3fs-$B -o storage_class=reduced_redundancy,allow_other,rw,umask=000,noatime,use_cache=/mnt/s3fs-$B-tmp,dbglevel=warn -f > /var/log/s3fs-$B.log.txt &
done

tail /dev/null -f

