#!/bin/bash

# Define a list of IP addresses where PostgreSQL is running
ip_list=("ip1" "ip2" "ip3")

# Define PostgreSQL super user credentials
psql_super_user={{super_user_username}}
psql_super_user_password={{super_user_password}}
export PGPASSWORD="$psql_super_user_password"

# Define password for the new user and database name
password={{pass}}
dbname=postgres

# Loop through each IP address to execute PostgreSQL commands
for current_ip in "${ip_list[@]}"; do
    echo "Running script for IP: $current_ip"

    # Check if the role 'onetrust_access' already exists in the database
    role_exists=$(psql -X -h $current_ip -U $psql_super_user -d $dbname -tAc "SELECT 1 FROM pg_roles WHERE rolname = 'onetrust_access';")

    # Create the role if it does not exist
    if [[ $role_exists -eq 1 ]]; then
        echo "Role onetrust_access already exists."
    else
        echo "Creating role onetrust_access..."
        # Set of commands to create and configure the new role 'onetrust_access'
        psql -X -h $current_ip -U $psql_super_user -d $dbname -c "set role = gtldb_superuser; CREATE ROLE onetrust_access;"
        psql -X -h $current_ip -U $psql_super_user -d $dbname -c "set role = gtldb_superuser; ALTER ROLE onetrust_access INHERIT;"
        psql -X -h $current_ip -U $psql_super_user -d $dbname -c "set role = gtldb_superuser; ALTER ROLE onetrust_access NOLOGIN;"
    fi

    # Check if the user 'gtl_onetrust' already exists
    user_exists=$(psql -X -h $current_ip -U $psql_super_user -d $dbname -tAc "SELECT 1 FROM pg_roles WHERE rolname = 'gtl_onetrust';")

    # Create the user if it does not exist
    if [[ $user_exists -eq 1 ]]; then
        echo "User gtl_onetrust already exists."
    else
        echo "Creating user gtl_onetrust..."
        # Command to create new user 'gtl_onetrust' with an encrypted password
        psql -X -h $current_ip -U $psql_super_user -d $dbname -c "set role = gtldb_superuser; CREATE USER gtl_onetrust ENCRYPTED PASSWORD '$password';"
    fi

    # Check if the user 'gtl_onetrust' is already a member of the role 'onetrust_access'
    user_in_role=$(psql -X -h $current_ip -U $psql_super_user -d $dbname -tAc "SELECT 1 FROM pg_user WHERE usename = 'gtl_onetrust' AND usesysid = ANY (SELECT roleid FROM pg_auth_members WHERE member = 'gtl_onetrust'::regrole);")

    # Add the user to the role if not already a member
    if [[ $user_in_role -eq 1 ]]; then
        echo "User gtl_onetrust is already in role onetrust_access."
    else
        echo "Adding user gtl_onetrust to role onetrust_access..."
        # Command to add 'gtl_onetrust' to the role 'onetrust_access'
        psql -X -h $current_ip -U $psql_super_user -d $dbname -c "set role = gtldb_superuser; GRANT onetrust_access TO gtl_onetrust;"
    fi

    # Grant SELECT privileges to the role 'onetrust_access'
    echo "Granting SELECT privileges to role onetrust_access..."
    psql_output=$(psql -X -h $current_ip -U $psql_super_user -d $dbname -c "set role = gtldb_superuser; GRANT SELECT ON ALL TABLES IN SCHEMA public TO onetrust_access;" 2>&1)

    # Check the success of the GRANT operation and display appropriate messages
    if [[ $? -eq 0 ]]; then
        echo "SELECT privileges granted successfully."
    else
        echo "Error granting SELECT privileges:"
        echo "$psql_output"
    fi

    # Display information about the newly created/updated roles and users
    echo "Roles and Users with Permissions:"
    psql -X -h $current_ip -U $psql_super_user -d $dbname -c "\du+ onetrust_access"
    sleep 2
    psql -X -h $current_ip -U $psql_super_user -d $dbname -c "\du+ gtl_onetrust"
    sleep 2

    echo "Script completed for IP: $current_ip"
done
