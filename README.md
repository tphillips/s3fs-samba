# s3fs-samba
A docker container which mounts an s3 bucket and shares it using samba

To use:

docker run --name s3fs-samba \
	--restart always -d --privileged \
	-p 139:139 \
	-p 445:445 \
	-e AWSKEY="Your AWS Key" \
	-e AWSSECRET="Your AWS Secret" \
	-e SMBUSER="Username for smb access" \
	-e SMBPASS="Password for smb access" \
	-e BUCKET="Your S3 bucket name" \
	tphillips/s3fs-samba

Note that:

* The s3fs mount is configure to use a local cache at /mnt/s3fs-tmp and according to https://github.com/s3fs-fuse/s3fs-fuse/wiki/FAQ this is unbounded!  This can be turned off in the fstab line in start.sh
* The s3fs mount is configured to use reduced redundancy storage. This can also be modified in the fstab line in start.sh
