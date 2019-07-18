#!/bin/sh


__create_rundir() {
	mkdir -p /var/run/sshd
}


__create_hostkeys() {
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 
}

__ip_address() {
IPADDRESS="$(/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')"
echo IP Address: $IPADDRESS
}


# Call all functions
__create_rundir
__create_hostkeys
__create_user
__ip_address

exec /usr/sbin/sshd -D -p 3456 -e "$@"
