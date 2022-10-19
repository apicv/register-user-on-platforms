#/usr/bin/env bash
rm users_generated.csv
FILE=users_bo.csv
NUM_LINES=`cat ${FILE} | wc -l`
for (( COUNTER=2; COUNTER<=${NUM_LINES}; COUNTER++ ))
do
    LINE=`sed "${COUNTER}q;d" ${FILE}`
    IFS=',' read -r -a row <<< "${LINE}"
    #echo "user_login: $column2"
    #echo "email: $column5"
    #echo "Nom: $column9"
    nom_low=$(sed -e 's/[Ññ]/n/g' -e 's/[àáâãäåÀÁ]/a/g' -e 's/[èéêëÈÉ]/e/g' -e 's/[ìíîïÍÌí]/i/g' -e 's/[òóòöÒÓ]/o/g' -e 's/[ùúûüÚÙ]/u/g' <<< ${row[9]} | tr '[:upper:]' '[:lower:]')
    #echo "nom_low: $nom_low"
    #echo "Cognoms: $column10"


    # Remove DEL on last name: Del pozo -> pozo
    cognoms_low=$(echo ${row[10]} | tr '[:upper:]' '[:lower:]' | sed -e 's/del //')

    # Replace accents
    cognoms_low=$(echo $cognoms_low | sed -e 's/[Ññ]/n/g' -e 's/[àáâãäåÀÁ]/a/g' -e 's/[èéêëÈÉ]/e/g' -e 's/[ìíîïÍÌ]/i/g' -e 's/[òóòöÒÓ]/o/g' -e 's/[ùúûüÚÙ]/u/g')

    # Only one last name
    #cognoms_low=$(echo $cognoms_low | cut -d ' ' -f1)
    # Remove spaces in last_name
    cognoms_low=$(echo $cognoms_low | tr -d ' ')
    #echo "Cognoms_low: $cognoms_low"
    new_user_name=$(cut -c 1 <<< $nom_low )
    sec_name=$(cut -d" " -f2 <<< $nom_low)
    
    # Has a second name
    #if [ "$sec_name" != "$nom_low" ]; then
    #    sec_name=$(cut -c1 <<< $sec_name)
    #    new_user_name=$(echo "${new_user_name}${sec_name}")
    #fi

    #new_user_name=$(echo ${new_user_name}.${cognoms_low})
    new_user_name=$(echo ${row[5]} | cut -d'@' -f1)

    #echo "nou_user: ${new_user_name}"

    ./alta_apicv_user.sh "${row[5]}" "${row[9]}" "${row[10]}" "${new_user_name}"

    echo "${row[2]},${row[5]},${row[9]},${row[10]},${new_user_name}," >> users_generated.csv
echo 
done
exit 0
while IFS="," read -r column0 column1 column2 column3 column4 column5 column6 column7 column8 column9 column10 column11 column12 column13 column14 column15 column16 column17 column18 column19 column20 column21 column22 column23 column24 column25 column26
do
    #echo "user_login: $column2"
    #echo "email: $column5"
    #echo "Nom: $column9"
    nom_low=$(sed -e 's/[Ññ]/n/g' -e 's/[àáâãäåÀÁ]/a/g' -e 's/[èéêëÈÉ]/e/g' -e 's/[ìíîïÍÌí]/i/g' -e 's/[òóòöÒÓ]/o/g' -e 's/[ùúûüÚÙ]/u/g' <<< $column9 | tr '[:upper:]' '[:lower:]')
    #echo "nom_low: $nom_low"
    #echo "Cognoms: $column10"


    # Remove DEL on last name: Del pozo -> pozo
    cognoms_low=$(echo $column10 | tr '[:upper:]' '[:lower:]' | sed -e 's/del //')

    # Replace accents
    cognoms_low=$(echo $cognoms_low | sed -e 's/[Ññ]/n/g' -e 's/[àáâãäåÀÁ]/a/g' -e 's/[èéêëÈÉ]/e/g' -e 's/[ìíîïÍÌ]/i/g' -e 's/[òóòöÒÓ]/o/g' -e 's/[ùúûüÚÙ]/u/g')

    # Only one last name
    #cognoms_low=$(echo $cognoms_low | cut -d ' ' -f1)
    # Remove spaces in last_name
    cognoms_low=$(echo $cognoms_low | tr -d ' ')
    #echo "Cognoms_low: $cognoms_low"
    new_user_name=$(cut -c 1 <<< $nom_low )
    sec_name=$(cut -d" " -f2 <<< $nom_low)
    
    # Has a second name
    #if [ "$sec_name" != "$nom_low" ]; then
    #    sec_name=$(cut -c1 <<< $sec_name)
    #    new_user_name=$(echo "${new_user_name}${sec_name}")
    #fi

    #new_user_name=$(echo ${new_user_name}.${cognoms_low})
    new_user_name=$(echo ${column5} | cut -d'@' -f1)

    #echo "nou_user: ${new_user_name}"

    ./alta_apicv_user.sh "${column5}" "${column9}" "${column10}" "${new_user_name}"
    echo "MASS $?"
    echo "${column2},${column5},${column9},${column10},${new_user_name}," >> users_generated.csv
done <  <(tail -n +2 users.csv)
#./alta_apicv_user.sh belda@juan.com 'Juan' 'Sanz Belda' sanz_juan