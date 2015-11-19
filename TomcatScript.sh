#!/bin/bash
# This script will check whether java installed and then install tomcat7
Tomcat7_VER='7.0.65'



# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi
#check if java installed
echo "Checking if java installed..."
echo
JavaLocation=$(which java || exit 1)
if [ $JavaLocation ]; then
    JavaVer=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')
    echo "Java have been installed and the version is $JavaLocation"
else
    echo "Java is not installed and start to install java..."
    sleep 1
    echo
    yum -y install java &&
        JavaVer=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')
    echo 
    echo "Install Java complted and the version is $JavaVer"
fi

Start to install tomcat6
echo
echo "Start to install tomcat6..."
sleep 1
yum -y install tomcat6 tomcat6-webapps tomcat6-admin-webapps
chkconfig tomcat6 on
service tomcat6 start
service tomcat6 status


echo "####################################################################################################"
echo
echo "Install tomcat6 completed, you can check http://localhot:8080 now."

echo "Tomcat Service Config: /etc/tomcat6 (main config directory)"
echo "Release Notes        : ﻿/usr/share/doc/tomcat*"
echo "Bin Directory        : /usr/share/tomcat6"
echo "Webapps              : /var/lib/tomcat6/webapps"
echo "Logs                 : /var/log/tomcat6"

echo
JavaVer=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')
echo "The Java version is $JavaVer"
echo "Please make sure the Java version is 1.8, otherwise you should update your Java to 1.8"
echo "####################################################################################################"

#Start to install tomcat7
#echo
#echo "Start to install tomcat7..."
#sleep 1
#cd /tmp
#echo "Download tomcat7 archive file to /tmp directory ..."
#wget http://www.us.apache.org/dist/tomcat/tomcat-7/v$Tomcat7_VER/bin/apache-tomcat-$Tomcat7_VER.tar.gz &&
#echo
#echo "Extract tomcat7 archive file in /tmp directory"
#tar xzf apache-tomcat-$Tomcat7_VER.tar.gz &&
#mv apache-tomcat-$Tomcat7_VER /usr/local/tomcat7 &&
#cd /usr/local/tomcat7
#./bin/startup.sh

#echo "####################################################################################################"
#echo
#echo "Install tomcat7 completed, you can check http://localhot:8080 now."
#echo "Tomcat 7 path: /usr/local/tomcat7"
#echo "Start tomcat7: Go to /usr/local/tomcat7/bin/ and execute startup.sh"
#echo "Stop tomcat7: Go to /usr/local/tomcat7/bin/ and execute shutdown.sh"
#echo
#JavaVer=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')
#echo "The Java version is $JavaVer"
#echo "Please make sure the Java version is 1.8, otherwise you should update your Java to 1.8"
#echo "####################################################################################################"
