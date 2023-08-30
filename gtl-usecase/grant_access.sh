#!/bin/bash

getData=`PGPASSWORD=$stg_jenkins_super_user_pass

#set IFS special bash variable to coma
IFS=','


echo "++++++++++++++++++++++"
echo "Checking role existed"
echo "Checking db existed"
echo "+++++++++++++++++++++"
echo ""
sleep 3

#validate role dan database
validate=`psql -X -h $ipps -U $stg_jenkins_super_username -d $dbname -t -c "SELECT count(*) FROM pg_roles where rolname = 'gtl_bqetl_stg';" | xargs`
validatedb=`psql -X -h $ipps -U $stg_jenkins_super_username -d $dbname -t -c "SELECT count(*) FROM pg_database where datname = '$dbname';" | xargs`

#jika role dan database ada, run if
 if [[ $validate = 1 && $validatedb = 1 ]]
 then
    echo "+++++++++++++++++++++++++++"
    echo "Checking all good, continue"
    echo "+++++++++++++++++++++++++++"
    echo ""
    sleep 3
#jika gagal. stop script. check role dan dbname.
else
    echo "Validation failed. Either gtl_bqetl_stg role is missing or the database $dbname doesn't exist."
    exit 1  # This will stop the script
fi

echo "+++++++++++++++++++++++++++"
echo "Checking table availability"
echo "+++++++++++++++++++++++++++"
echo ""
sleep 3
tablecount=0

for table in $tablename
do
    tablecount=$tablecount
    validatetables=`psql -X -h $ipps -U $stg_jenkins_super_username -d $dbname -t -c "\dt"|grep -wc $table|xargs`
if [ "$validatetables" = 0 ]
then
    echo "Table $table doesn't exists";
    tablecount=$((tablecount + 1))
    sleep 3
fi
done

if [ $tablecount = 0 ]
then
    echo "OK.. Table exists, continue to next step"
	echo ""
else
    echo "Please recheck table name, make sure table exists on database $dbname"
	echo ""
    exit 1
fi
sleep 5

echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++"
echo "Grant Select on listed tables to gtl_bqetl_stg"
echo "++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
sleep 3

for table in $tablename; do
    psql -X -h $ipps -U $stg_jenkins_super_username -d $dbname -c "\z $table"
    psql -X -h $ipps -U $stg_jenkins_super_username -d $dbname -c "grant select on $table to analytic_access;"
    psql -X -h $ipps -U $stg_jenkins_super_username -d $dbname -c "\z $table"

    validatetables=$(psql -X -h $ipps -U $stg_jenkins_super_username -d $dbname -t -c "\z $table" | grep -wc analytic_access | xargs)
if [ "$validatetables" = 1 ]; then
    echo "Grant select for table $table Done"
    sleep 3
else
    echo "Grant select for table $table Failed"
    sleep 3
fi
done

# Unset the PGPASSWORD environment variable after using it
unset PGPASSWORD