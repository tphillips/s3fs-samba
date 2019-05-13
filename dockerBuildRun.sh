docker stop s3fs-samba
docker rm s3fs-samba
docker build -t tphillips/s3fs-samba .
docker run --name s3fs-samba \
	--restart always -d --privileged \
	-p 139:139 \
	-p 445:445 \
	-e AWSKEY="your-aws-key" \
	-e AWSSECRET="your-aws-secret" \
	-e SMBUSER="name-for-smbuser" \
	-e SMBPASS="password-for-smbuser" \
	-e BUCKET="your-s3-bucket" \
	tphillips/s3fs-samba
