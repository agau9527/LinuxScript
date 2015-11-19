#!/bin/sh
# Instal zabbix server dependencies: LAMP
# Apache httd server, mysql server, php and its dependencies
# Update 2015.08.03

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#Install All Services
echo "Start to install Apache httpd service"
yum -y install httpd httpd-devel &&
echo 
echo "Start to install mysql server"
yum -y install mysql mysql-server &&
echo 
echo "Start to install php and dependencies"
yum -y install php php-cli php-common php-devel php-pear php-gd php-mbstring php-mysql php-xml &&
echo 

#Start All Services
service httpd start
service mysqld start

#MySQL Initial Setup
echo 
echo "Initialize mysql server and it need to set secure settings."
sleep 3
mysql_secure_installation
