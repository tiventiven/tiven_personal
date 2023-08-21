# Replace these values with your actual information
ipss=$ipss
userdb=$userdb
dbname=$dbname
    
    validate=`psql -X -h $ipps -U $userdb -d $dbname -t -c "SELECT count(*) FROM pg_roles where rolname = 'gtl_bqetl_stg';" | xargs`
    validatedb=`psql -X -h $ipps -U $userdb -d $dbname -t -c "SELECT count(*) FROM pg_database where datname = '$dbname';" | xargs`

 if [[ $validate = 0 && $validatedb = 1 ]]
    then
        psql -X -h $ipps -U $userdb  -d $dbname -c "set role = gtldb_superuser;" -c "CREATE ROLE gtl_bqetl_stg;"
        psql -X -h $ipps -U $userdb  -d $dbname -c "set role = gtldb_superuser;" -c "ALTER ROLE gtl_bqetl_stg PASSWORD '';"
        psql -X -h $ipps -U $userdb  -d $dbname -c "set role = gtdb_superuser;" -c "COMMENT ON ROLE gtl_bqetl_stg  IS 'blablabla';"
        psql -X -h $ipps -U $userdb  -d $dbname -c "set role = gtdb_superuser;" -c "ALTER GROUP analytic_access ADD USER gtl_bqetl_stg;"
fi