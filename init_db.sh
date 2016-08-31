#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER geonode WITH PASSWORD 'geonode';
    CREATE DATABASE geonode OWNER geonode;
    CREATE DATABASE geonode_data OWNER geonode;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "geonode_data" <<-EOSQL
    CREATE EXTENSION postgis;
    CREATE EXTENSION postgis_topology;
    GRANT ALL ON geometry_columns TO PUBLIC;
    GRANT ALL ON spatial_ref_sys TO PUBLIC;
EOSQL
