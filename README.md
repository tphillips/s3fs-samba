# s3fs-samba
A docker container which mounts an s3 bucket and shares it using samba

To use:

* Add your s3 credentials to the passwd-s3fs file
* Add your bucket name to the fstab-add file
* run ./cleanBuildRun.sh
* The container will start and ask you to set the password for the storageuser
* By default the access username is "storageuser" and the share is "Storage"
