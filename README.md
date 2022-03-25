# docker-fileserver
Debian Linux (v11 - bullseye) based Time Machine / Samba / NFS server

## To be supported: (work in progress)
- Time Machine backups from my Macbook Pro
- Samba access from my Macbook Pro
- Samba access from my Windows 10 & 11 machines
- NFS access from my Ubuntu 20.04 & 22.04 machines

## How to use this image:
- Provide a /config directory through '-v path-to-config:/config' parameter. In this config directory you can put your afp.conf and smb.conf files, as well as users.conf and groups.conf.
- users.conf file defines users as user:uid:group:password
- groups.conf file defines groups as group:gid
- smb.conf is configuration used for samba
- afp.conf is configuration used for afp.
  
### Typical command to run this image:
- docker run -d --privileged --net=host -v /exports:/exports hurenkam/fileserver:latest

### If you wish to run it on seperate network (note: avahi won't work then):
- docker run -d --privileged -v /exports:/exports -p 111:111 -p 137:137 -p 138:138 -p 445:445 -p 548:548 -p 2049:2049 -p 32765:32765 -p 32766:32766 -p 32767:32767 -p 32768:32768 hurenkam/fileserver:latest

## Credits:
Before i put this together, i studied docker & alpine documentation, as well as several other docker images. 
Some of the ideas and scripts in this image are based on these other images:
- https://hub.docker.com/r/mbentley/timemachine/
- https://hub.docker.com/r/kartoffeltoby/docker-nas-samba/
- https://hub.docker.com/r/fuzzle/docker-nfs-server/

