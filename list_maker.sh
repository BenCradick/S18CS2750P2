#!/bin/sh
#function to handle inturrupt
cntr_c() {
    rm tmp.txt cs-upper cs-lower
    exit
}
#catches inturrupt
trap cntr_c SIGINT

#nested while loop because it was easier than writing every variable name
#also without additional loop the script was excluding the last line
#not a high usage script its ok to be inefficient.
while read f || [[ -n $f ]]; do
#make temp file to be read from
    echo $f > tmp.txt
    #specify "," as field seperator and give each section its own variable
    while IFS="," read  major last first ID level email_address ; do
    #splits up juniors and seniors
        if [ "$level" == "junior" ] || [ "$level" == "senior" ] || [ "$level" == "Junior" ] || [ "$level" == "Senior" ]; then
            echo "$email_address \t ( $first $last )" >> cs-upper
            #sort out underclassmen
        elif [ "$level" == "sophomore" ] || [ "$level" == "freshman" ] || [ "$level" == "Sophomore" ] || [ "$level" == "Freshman" ]; then
            echo "$email_address \t ( $first $last )" >> cs-lower
        fi
        sleep 5
        
        #take input from tmp.txt
    done < tmp.txt
    #86 tmp.txt
    rm tmp.txt
    #take input from email
done < email
