#!/bin/bash

#Update and upgrade packages
 echo "siap update cok"
sleep 3
sudo apt update
sudo apt upgrade -y
echo "update pertama selesai cok"
sleep 1
echo "siap install sisanya bro"
sudo apt-get install vim
sudo apt-get install net-tools
sudo apt-get install wget ca-certificates
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
sudo apt-get update
sudo apt-get install postgresql-12 postgresql-12-pglogical -y
echo "selesai semua bro"
sleep 2
echo "membuat .pgpass"
cd
cat <<EOF > ~/.pgpass
hostname:port:database:username:password
*:5432:*:admin:admin123
EOF
sleep 2
echo "jalanin script kedua untuk postgres"
cd
sudo mkdir -p /data/postgres/data
sudo chown postgres. -R /data/postgres
sudo su - postgres -c "/etc/latihan/postgres_setup.sh"