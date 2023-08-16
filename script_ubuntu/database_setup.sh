#!/bin/bash

read -p "What is the user name: " user_1
read -p "What is the password for the user: " user_password1

#code
psql -c "CREATE DATABASE testing;"
echo "membuat table testing_userlist"
sleep 3
psql -d testing -c "CREATE TABLE testing_userlist(user_id SERIAL PRIMARY KEY UNIQUE,first_name VARCHAR(50),last_name VARCHAR(50),created_on TIMESTAMP NOT NULL);"
echo "mengisi table testing_userlist"
sleep 3
psql -d testing -c "INSERT INTO testing_userlist(first_name,last_name,created_on) VALUES ('tiven','hunter',CURRENT_TIMESTAMP),('shaina','angelica',CURRENT_TIMESTAMP);"
psql -c "CREATE ROLE $user_1;"
psql -c "ALTER ROLE $user_1 WITH LOGIN ENCRYPTED PASSWORD '$user_password1'"
psql -c "ALTER GROUP admin ADD USER $user_1;"
psql -d testing -c "GRANT ALL PRIVILEGES ON testing_userlist TO admin;"
psql -d testing -c "TABLE testing_userlist;"
# psql -d testing -c "\l+"