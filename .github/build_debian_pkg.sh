#/bin/sh
set -ex

## Prerequisites
mkdir /opt/assets/
ls /opt/ossh-src/debian/openssh-pq-server/etc

##Building the Client
mkdir -p /opt/ossh-src/debian/openssh-pq-client/etc/ssh/ssh_config.d
mv /opt/ossh-src/ssh_config /opt/ossh-src/debian/openssh-pq-client/etc/ssh/ssh_config

mv /opt/ossh-src/scp /opt/ossh-src/debian/openssh-pq-client/usr/bin/scp
mv /opt/ossh-src/sftp /opt/ossh-src/debian/openssh-pq-client/usr/bin/sftp

mv /opt/ossh-src/ssh /opt/ossh-src/debian/openssh-pq-client/usr/bin/ssh
mv /opt/ossh-src/ssh-add /opt/ossh-src/debian/openssh-pq-client/usr/bin/ssh-add 
mv /opt/ossh-src/ssh-agent /opt/ossh-src/debian/openssh-pq-client/usr/bin/ssh-agent
mv /opt/ossh-src/ssh-keygen /opt/ossh-src/debian/openssh-pq-client/usr/bin/ssh-keygen
mv /opt/ossh-src/ssh-keyscan /opt/ossh-src/debian/openssh-pq-client/usr/bin/ssh-keyscan

mv /opt/ossh-src/ssh-keysign /opt/ossh-src/debian/openssh-pq-client/usr/lib/openssh/ssh-keysign 
mv /opt/ossh-src/ssh-pkcs11-helper /opt/ossh-src/debian/openssh-pq-client/usr/lib/openssh/ssh-pkcs11-helper
mv /opt/ossh-src/ssh-sk-helper /opt/ossh-src/debian/openssh-pq-client/usr/lib/openssh/ssh-sk-helper

mkdir /opt/ossh-src/debian/openssh-pq-client/usr/lib/systemd/user/graphical-session-pre.target.wants
ln -sf /opt/ossh-src/debian/openssh-pq-client/usr/lib/systemd/user/ssh-agent.service /opt/ossh-src/debian/openssh-pq-client/usr/lib/systemd/user/graphical-session-pre.target.wants
ln -sf /opt/ossh-src/debian/openssh-pq-client/usr/bin/ssh /opt/ossh-src/debian/openssh-pq-client/usr/bin/slogin

chmod -R 755 /opt/ossh-src/debian/openssh-pq-client/
cd /opt/ossh-src/debian/ && dpkg-deb --build openssh-pq-client
mv /opt/ossh-src/debian/openssh-pq-client.deb /opt/assets/


## Building the Server
mkdir -p /opt/ossh-src/debian/openssh-pq-server/etc/runit/runsvdir/default
mkdir -p /opt/ossh-src/debian/openssh-pq-server/etc/ssh/sshd_config.d
mkdir -p /opt/ossh-src/debian/openssh-pq-server/sbin
mkdir -p /opt/ossh-src/debian/openssh-pq-server/var/log/runit/ssh
mkdir -p /opt/ossh-src/debian/openssh-pq-server/usr/share/openssh

mv /opt/ossh-src/sshd_config /opt/ossh-src/debian/openssh-pq-server/usr/share/openssh

mv /opt/ossh-src/sshd /opt/ossh-src/debian/openssh-pq-server/sbin/sshd
ln -sf /opt/ossh-src/debian/openssh-pq-server/usr/share/doc/openssh-client /opt/ossh-src/debian/openssh-pq-server/usr/share/doc/openssh-server

chmod -R 755 /opt/ossh-src/debian/openssh-pq-server/
cd /opt/ossh-src/debian/ && dpkg-deb --build openssh-pq-server
mv /opt/ossh-src/debian/openssh-pq-server.deb /opt/assets/
