#!/bin/bash
psql -c "CREATE DATABASE testing;"
echo "membuat table testing_userlist"
sleep 3
psql -d testing -c "CREATE TABLE testing_userlist(user_id SERIAL PRIMARY KEY UNIQUE,first_name VARCHAR(50),last_name VARCHAR(50),created_on TIMESTAMP NOT NULL);"
echo "mengisi table testing_userlist"
sleep 3
psql -d testing -c "INSERT INTO testing_userlist(first_name,last_name,created_on) VALUES ('tiven','hunter',CURRENT_TIMESTAMP),('shaina','angelica',CURRENT_TIMESTAMP);"
psql -c "CREATE ROLE tiven;"
psql -c "CREATE ROLE enggar;"
psql -c "ALTER ROLE tiven WITH LOGIN ENCRYPTED PASSWORD 'handiko123'"
psql -c "ALTER ROLE enggar WITH LOGIN ENCRYPTED PASSWORD 'enggar'"
psql -c "ALTER GROUP admin ADD USER tiven, enggar;"
psql -d testing -c "GRANT ALL PRIVILEGES ON testing_userlist TO admin;"
psql -d testing -c "TABLE testing_userlist;"
# psql -d testing -c "\l+"