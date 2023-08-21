# Replace these values with your actual information
ipps=192.168.64.8
userdb=admin
dbname=logical
    
    echo "++++++++++++++++"
    echo "Checking db user"
    echo "++++++++++++++++"
    echo ""
    sleep 3
    validate=`psql -X -h $ipps -U $userdb -d $dbname -t -c "SELECT count(*) FROM pg_roles where rolname = 'gtl_bqetl_stg';" | xargs`
    validatedb=`psql -X -h $ipps -U $userdb -d $dbname -t -c "SELECT count(*) FROM pg_database where datname = '$dbname';" | xargs`

 if [[ $validate = 0 && $validatedb = 1 ]]
    then
        psql -X -h $ipps -U $userdb  -d $dbname -c "set role = gtldb_superuser;" -c "CREATE ROLE gtl_bqetl_stg;"
        psql -X -h $ipps -U $userdb  -d $dbname -c "set role = gtldb_superuser;" -c "ALTER ROLE gtl_bqetl_stg PASSWORD '123';"
        psql -X -h $ipps -U $userdb  -d $dbname -c "set role = gtldb_superuser;" -c "COMMENT ON ROLE gtl_bqetl_stg  IS 'blablabla';"
        echo "Create role gtl_bqetl_stg done";
        sleep 2
fi
    echo "+++++++++++++++++"
    echo "Checking db group"
    echo "+++++++++++++++++"
    echo ""
    sleep 3
    validategroup=`psql -X -h $ipps -U $userdb -d $dbname -t -c "\du+ gtl_bqetl_stg"|grep -wc analytic_access|xargs`
            if [ "$validategroup" = 0 ]
       then
        psql -X -h $ipps -U $userdb  -d $dbname -c "set role = gtldb_superuser;" -c "GRANT analytic_access to gtl_bqetl_stg;"
fi
valcreate=`psql -X -h $ipps -U $userdb -d $dbname -t -c "SELECT count(*) FROM pg_roles where rolname = 'gtl_bqetl_stg';" | xargs`

    if [ $valcreate = 1 ]
    then
        echo "gtl_bqetl_stg is already registered on this DB";
	echo ""
	sleep 2
    else
        echo "failed to create role gtl_bqetl_stg please contact DBA team";
	sleep 2
    fi
