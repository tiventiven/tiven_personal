# Replace these values with your actual information
ipss=$ipss
userdb=$userdb
dbname=$dbname
    
    validate=`psql -X -h $ipps -U $userdb -d $dbname -t -c "SELECT count(*) FROM pg_roles where rolname = 'gtl_bqetl_stg';" | xargs`
    validatedb=`psql -X -h $ipps -U $userdb -d $dbname -t -c "SELECT count(*) FROM pg_database where datname = '$dbname';" | xargs`

if [[ $validate = 1 && $validatedb = 1 ]]
    then
IFS=','
    for table in $tablename
    do
        psql -X -h $ipps -U $userdb -d $dbname -c "\z $table"
        psql -X -h $ipps -U $userdb -d $dbname -c "grant select on $table to analytic_access;"
        psql -X -h $ipps -U $userdb -d $dbname -c "\z $table"

	validatetables=`psql -X -h $ipps -U $userdb -d $dbname -t -c "\z $table"|grep -wc analytic_access|xargs`
    	if [ "$validatetables" = 1 ]

        then
            echo "Grant select for table $table Done";
	    sleep 3
        else
            echo "Grant select for table $table Failed";
	    sleep 3
        fi