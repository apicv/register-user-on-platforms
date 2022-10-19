#/usr/bin/env bash

## Following lines are used without docker
#source .env
#export $(cut -d= -f1 .env)

email=$1
firstName=$2
lastName=$3
username=$4
password="provaa"
if [ $# -ne 4 ];
then
    echo "./alta_apicv_user.sh email 'nom' 'cognoms' usuari"
    echo "EXEMPLE:"
    echo "./alta_apicv_user.sh belda@juan.com 'Juan' 'Sanz Belda' sanz_juan"
    exit 1
fi
echo $email $firstName $lastName $username
# --debug true 
password=$(phantomjs --ignore-ssl-errors true --cookies-file=out/cookie alta_usuari.js "$firstName" "$lastName" "$username" "$email")
echo "The password for ${username} is: ${password}"
phantomjs --ignore-ssl-errors true alta_email.js $username $password 2>/dev/null

node send_email.js $email $username $password

exit 0
