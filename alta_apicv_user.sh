#/usr/bin/env bash
source .env
export $(cut -d= -f1 .env)

email=$1
firstName=$2
lastName=$3
username=$4

if [ $# -ne 4 ];
then
    echo "./alta_apicv_user.sh email 'nom' 'cognoms' usuari"
    echo "EXEMPLE:"
    echo "./alta_apicv_user.sh belda@juan.com 'Juan' 'Sanz Belda' sanz_juan"
    exit 1
fi
password=$(phantomjs alta_usuari.js "$firstName" "$lastName" "$username")
echo $password
phantomjs alta_email.js $username $password

nodejs send_email.js $email $username $password
