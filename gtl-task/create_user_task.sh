#!/bin/bash
# Define a list of IP addresses
ip_list=("ip1" "ip2" "ip3")

psql_super_user={{super_user_username}}
psql_super_user_password={{super_user_password}}
export PGPASSWORD="$psql_super_user_password"
password={{pass}}
dbname=postgres

# Loop through each IP address
for current_ip in "${ip_list[@]}"; do
    echo "Running script for IP: $current_ip"

    # Check if onetrust_access role already exists
    role_exists=$(psql -X -h $current_ip -U $psql_super_user -d $dbname -tAc "SELECT 1 FROM pg_roles WHERE rolname = 'onetrust_access';")

    if [[ $role_exists -eq 1 ]]; then
        echo "Role onetrust_access already exists."
    else
        echo "Creating role onetrust_access..."
        psql -X -h $current_ip -U $psql_super_user -d $dbname -c "set role = gtldb_superuser; CREATE ROLE onetrust_access;"
        psql -X -h $current_ip -U $psql_super_user -d $dbname -c "set role = gtldb_superuser; ALTER ROLE onetrust_access INHERIT;"
        psql -X -h $current_ip -U $psql_super_user -d $dbname -c "set role = gtldb_superuser; ALTER ROLE onetrust_access NOLOGIN;"
    fi

    # Check if gtl_onetrust user already exists
    user_exists=$(psql -X -h $current_ip -U $psql_super_user -d $dbname -tAc "SELECT 1 FROM pg_roles WHERE rolname = 'gtl_onetrust';")

    if [[ $user_exists -eq 1 ]]; then
        echo "User gtl_onetrust already exists."
    else
        echo "Creating user gtl_onetrust..."
        psql -X -h $current_ip -U $psql_super_user -d $dbname -c "set role = gtldb_superuser; CREATE USER gtl_onetrust ENCRYPTED PASSWORD '$password';"
    fi

    # Check if gtl_onetrust is in onetrust_access role
    user_in_role=$(psql -X -h $current_ip -U $psql_super_user -d $dbname -tAc "SELECT 1 FROM pg_user WHERE usename = 'gtl_onetrust' AND usesysid = ANY (SELECT roleid FROM pg_auth_members WHERE member = 'gtl_onetrust'::regrole);")

    if [[ $user_in_role -eq 1 ]]; then
        echo "User gtl_onetrust is already in role onetrust_access."
    else
        echo "Adding user gtl_onetrust to role onetrust_access..."
        psql -X -h $current_ip -U $psql_super_user -d $dbname -c "set role = gtldb_superuser; GRANT onetrust_access TO gtl_onetrust;"
    fi

    # Grant SELECT privileges to onetrust_access role and validate
    echo "Granting SELECT privileges to role onetrust_access..."
    psql_output=$(psql -X -h $current_ip -U $psql_super_user -d $dbname -c "set role = gtldb_superuser; GRANT SELECT ON ALL TABLES IN SCHEMA public TO onetrust_access;" 2>&1)

    if [[ $? -eq 0 ]]; then
        echo "SELECT privileges granted successfully."
    else
        echo "Error granting SELECT privileges:"
        echo "$psql_output"
    fi

    # Display roles and users with permissions
    echo "Roles and Users with Permissions:"
    psql -X -h $current_ip -U $psql_super_user -d $dbname -c "\du+ onetrust_access"
    sleep 2
    psql -X -h $current_ip -U $psql_super_user -d $dbname -c "\du+ gtl_onetrust"
    sleep 2

    echo "Script completed for IP: $current_ip"
done