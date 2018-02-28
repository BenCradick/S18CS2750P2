#!/bin/sh
while read f || [[ -n $f ]]; do
    echo $f > tmp.txt
    while IFS="," read  major last first ID level email_address ; do
        if [ "$level" == "Junior" ] || [ "$level" == "Senior" ]; then
            echo "$email_address \t ( $first $last )" >> cs-upper
        elif [ "$level" == "Sophomore" ] || [ "$level" == "Freshman" ]; then
            echo "$email_address \t ( $first $last )" >> cs-lower
        fi
    done < tmp.txt
    rm tmp.txt
done < email