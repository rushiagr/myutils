#! /bin/bash
set -eux

# Usage ./keystone-new-user.sh <username> <tenantname> <user-type>
# User type can be demo or admin, defaults to demo

# Assumption: required environment vars are sourced

keystone tenant-create --name $2 --enabled true
keystone role-create --name $1role
keystone user-create --name $1 --tenant $2 --pass nova --email rushi.agr@gmail.com --enabled true

keystone user-role-add --user $1 --tenant $2 --role $1role
keystone user-role-add --user $1 --tenant $2 --role anotherrole
keystone user-role-add --user $1 --tenant $2 --role Member
