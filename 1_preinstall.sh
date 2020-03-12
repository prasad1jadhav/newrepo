#!/bin/bash
#dependency installations like..jdk,maven,mysql-server,nodejs,influxdb etc.
echo "installing jdk...**************************************************************************************************************1"
sudo apt-get update 
sudo apt-get install openjdk-8-jdk -y
sudo apt-get install openjdk-8-jre -y
echo "installing maven...************************************************************************************************************2"
sudo apt-get update
sudo apt-get install maven -y 
echo "installing mysql-server...******************************************************************************************************3"
sudo apt-get update
export temp_mysql_password="root123"
export DEBIAN_FRONTEND=noninteractive
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $temp_mysql_password"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $temp_mysql_password"
sudo debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password password $temp_mysql_password"
sudo debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password_again password $temp_mysql_password"
sudo apt-get install mysql-server-5.7 -y
echo "installing nodejs...**************************************************************************************************************4"
sudo apt-get install curl -y
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install nodejs -y
echo "installing and starting influxdb...***********************************************************************************************5"
sudo curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/lsb-release
echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo apt-get update
#sudo systemctl unmask influxdb.service
sudo apt-get install influxdb -y 
#sudo service influxdb start
sudo systemctl start influxdb
echo "dependecy installation info..######################################################################################################"
java -version
javac -version
mvn -version
mysql --version
node -v
npm -v
influxd
echo "###################################################################################################################################"
