#!/bin/bash
psql -c "CREATE DATABASE testing;"
psql -d testing -c "\l+"