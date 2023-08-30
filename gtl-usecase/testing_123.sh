#!/bin/bash

ipps=192.168.64.8
stg_jenkins_super_username=admin
stg_jenkins_super_user_pass=handiko123
dbname=logical

export PGPASSWORD=$stg_jenkins_super_user_pass


validate=`psql -X -h $ipps -U $stg_jenkins_super_username -d $dbname -t -c "SELECT count(*) FROM pg_roles where rolname = 'gtl_bqetl_stg';" | xargs`
validatedb=`psql -X -h $ipps -U $stg_jenkins_super_username -d $dbname -t -c "SELECT count(*) FROM pg_database where datname = '$dbname';" | xargs`

# run if there is no role, database exist.
if [[ $validate = 0 && $validatedb = 1 ]]
then
    psql -X -h $ipps -U $stg_jenkins_super_username --password $stg_jenkins_super_user_pass  -d $dbname -c "set role = gtldb_superuser;" -c "CREATE ROLE gtl_bqetl_stg;"
    psql -X -h $ipps -U $stg_jenkins_super_username --password $stg_jenkins_super_user_pass  -d $dbname -c "set role = gtldb_superuser;" -c "ALTER ROLE gtl_bqetl_stg PASSWORD '$stg_bqetl_user_pass';"
    psql -X -h $ipps -U $stg_jenkins_super_username --password $stg_jenkins_super_user_pass  -d $dbname -c "set role = gtldb_superuser;" -c "COMMENT ON ROLE gtl_bqetl_stg  IS 'blablabla';"
    echo "Create role gtl_bqetl_stg done";
    sleep 2
#jika gagal. stop script. check role dan dbname.
else
    echo "Validation failed. Either gtl_bqetl_stg role already exist or the database $dbname doesn't exist."
    exit 1  # This will stop the script
fi