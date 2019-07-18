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

__set_env() {
echo "export KUBERNETES_SERVICE_HOST=10.96.0.1" >> /etc/profile
echo "export KUBERNETES_SERVICE_PORT=443" >> /etc/profile
echo "export KUBERNETES_PORT_443_TCP_PROTO=tcp" >> /etc/profile
echo "export KUBERNETES_PORT_443_TCP_ADDR=10.96.0.1" >> /etc/profile
echo "export KUBERNETES_PORT=tcp://10.96.0.1:443" >> /etc/profile
}


# Call all functions
__create_rundir
__create_hostkeys
__create_user
__ip_address
__set_env

exec /usr/sbin/sshd -D -p 3456 -e "$@"
