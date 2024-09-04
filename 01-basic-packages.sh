#!/bin/bash
#

apt update
apt -y autoremove
apt -y  upgrade
apt -y  dist-upgrade

## install basic postfix, chrony time-server tool instead of default and other useful tools

## postfix for system alert is need
CFG_HOSTNAME_FQDN=`hostname -f`
echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
echo "postfix postfix/mailname string $CFG_HOSTNAME_FQDN" | debconf-set-selections
echo "iptables-persistent iptables-persistent/autosave_v4 boolean true" | debconf-set-selections
echo "iptables-persistent iptables-persistent/autosave_v6 boolean true" | debconf-set-selections
DEBIAN_FRONTEND=noninteractive

apt -y  install vim chrony openssh-server screen net-tools git mc postfix sendemail tmux  \
	sudo wget curl ethtool iptraf-ng traceroute telnet rsyslog software-properties-common \
	dirmngr parted gdisk apt-transport-https lsb-release ca-certificates iputils-ping \
	bridge-utils iptables jq conntrack gnupg nfs-common 

 
sed -i '/swap/s/^/#/' /etc/fstab
swapoff -a
modprobe br_netfilter
sysctl -w net.ipv4.ip_forward=1

echo ""
echo ""
echo "---------------------------------------------------------"
echo "Reboot to load kernel update if any and swapoff for k8s"
echo "---------------------------------------------------------"
echo ""
echo ""
