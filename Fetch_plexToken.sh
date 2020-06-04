#!/bin/bash
echo "Username"
read user
echo "Password"
read pass
echo "Client ID\Identification Name"
read clientidname

#Generate a random Client ID (32 digit\letters)
clientid=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
date=$(date "+%Y%m%d_%k%M")

echo '' #to Serve as a spacer from output
curl -s -X "POST" "https://plex.tv/users/sign_in.json" \
    -H "X-Plex-Version: 1.0.2" \
    -H "X-Plex-Product: $clientidname" \
    -H "X-Plex-Client-Identifier: $clientid" \
    -H "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
    --data-urlencode "user[password]=$pass" \
    --data-urlencode "user[login]=$user" \
    -o ./"$clientidname"_$date.json

echo "Credentials saved at ${clientidname}_$date"
echo "Parsing Json File for Crendtials"

jq . ./"$clientidname"_$date.json|head -n15   #'.' is in place for legacy JQ versions below 1.6 that require this value
