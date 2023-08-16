#!/bin/bash


pg_dropcluster --stop 12 main
pg_createcluster 12 testing -D /data/postgres/data
cat <<EOF > /etc/postgresql/12/testing/conf.d/master.conf
data_directory = '/data/postgres/data/'
listen_addresses = '*'
port = 5432
max_connections = 1096
ssl = off
shared_buffers = 955MB
work_mem = 32MB
maintenance_work_mem = 2GB
shared_preload_libraries = 'pg_stat_statements, pglogical'
pg_stat_statements.track = all
wal_level = logical
checkpoint_timeout = 15min
max_wal_size = 1GB
min_wal_size = 80MB
checkpoint_completion_target = 0.7
archive_mode = on
archive_command = '/bin/true'
max_wal_senders = 64
wal_keep_segments = 100
max_replication_slots = 100
hot_standby = on
hot_standby_feedback = on
log_destination = 'stderr'
logging_collector = on
log_directory = 'pg_log'
log_file_mode = 0600
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
log_truncate_on_rotation = on
log_rotation_age = 1d
log_rotation_size = 50MB
log_min_duration_statement = 100
log_checkpoints = on
log_line_prefix = '%t [%p] %q%u@%d %h '
#log_line_prefix = '%m [%p] %q%u@%d '
log_lock_waits = on
log_statement = 'none'
log_timezone = 'Asia/Jakarta'
timezone = 'Asia/Jakarta'
EOF
cat <<EOF >> /etc/postgresql/12/testing/pg_hba.conf
# Tambahan
host  replication postgres 10.164.0.0/16   md5
host  replication replicator 10.164.0.0/16   md5
host  all replicator 10.164.0.0/16   md5
host all postgres 192.168.64.0/24 md5
host all tiven 192.168.64.0/24 md5
host all +admin 192.168.64.0/24 md5
host all all 192.168.64.0/24 md5
EOF
pg_ctlcluster 12 testing start 
psql -c "CREATE ROLE admin; "
psql -c "alter role admin with SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS ENCRYPTED PASSWORD 'admin123';"
echo "waktunya create database"
sleep 2
sudo su - postgres -c "/etc/latihan/database_setup.sh"