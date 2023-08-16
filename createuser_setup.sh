#!/bin/bash

read -p "What is the user name: " user_1
read -p "What is the password for the user: " user_1

psql -c "CREATE ROLE $user_1;"
psql -c "ALTER ROLE $user_1 WITH LOGIN ENCRYPTED PASSWORD '$user_1'"
psql -c "ALTER GROUP admin ADD USER $user_1;"
##test