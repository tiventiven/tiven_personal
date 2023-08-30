#!/bin/bash

getData=`PGPASSWORD=$stg_jenkins_super_user_pass


echo "+++++++++++++++++"
echo "Checking db user "
echo "Checking database"
echo "+++++++++++++++++"
echo ""
sleep 3

# validate role and validate database.
validate=`psql -X -h $ipps -U $stg_jenkins_super_username -d $dbname -t -c "SELECT count(*) FROM pg_roles where rolname = 'gtl_bqetl_stg';" | xargs`
validatedb=`psql -X -h $ipps -U $stg_jenkins_super_username -d $dbname -t -c "SELECT count(*) FROM pg_database where datname = '$dbname';" | xargs`

# run if there is no role, database exist.
if [[ $validate = 0 && $validatedb = 1 ]]
then
    psql -X -h $ipps -U $stg_jenkins_super_username  -d $dbname -c "set role = gtldb_superuser;" -c "CREATE ROLE gtl_bqetl_stg;"
    psql -X -h $ipps -U $stg_jenkins_super_username  -d $dbname -c "set role = gtldb_superuser;" -c "ALTER ROLE gtl_bqetl_stg PASSWORD '$stg_bqetl_user_pass';"
    psql -X -h $ipps -U $stg_jenkins_super_username  -d $dbname -c "set role = gtldb_superuser;" -c "COMMENT ON ROLE gtl_bqetl_stg  IS 'blablabla';"
    echo "Create role gtl_bqetl_stg done";
    sleep 2
#jika gagal. stop script. check role dan dbname.
else
    echo "Either gtl_bqetl_stg role already exist or the database $dbname doesn't exist."
fi

echo "+++++++++++++++++"
echo "Checking db group"
echo "+++++++++++++++++"
echo ""
sleep 3

#validate group gtl_bqetl_stg dengan analytic_access.
validategroup=`psql -X -h $ipps -U $stg_jenkins_super_username -d $dbname -t -c "\du+ gtl_bqetl_stg"|grep -wc analytic_access|xargs`

#jika belum 1 group, di grant ke group
if [ "$validategroup" = 0 ]
then
    psql -X -h $ipps -U $stg_jenkins_super_username  -d $dbname -c "set role = gtldb_superuser;" -c "GRANT analytic_access to gtl_bqetl_stg;"
fi

echo "++++++++++++++++"
echo "Checking db user"
echo "++++++++++++++++"
echo ""
sleep 3

#checking role gtl_bqetl_stg exist
valcreate=`psql -X -h $ipps -U $stg_jenkins_super_username -d $dbname -t -c "SELECT count(*) FROM pg_roles where rolname = 'gtl_bqetl_stg';" | xargs`

if [ $valcreate = 1 ]
then
    echo "gtl_bqetl_stg is already registered on this DB";
	echo ""
	sleep 2
else
    echo "failed to create role gtl_bqetl_stg please contact DBA team";
	sleep 2
fi

# Unset the PGPASSWORD environment variable after using it
unset PGPASSWORD