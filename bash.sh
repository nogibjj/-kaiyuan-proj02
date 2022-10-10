#! /usr/bin/env bash

echo "enter your csv filename"
read filename
if [ -e "$filename" ]
then
    # filter and save as csv file
	echo "enter your key word for filtering"
	read keyword
	grep -i "$keyword" "$filename" > filterResults.csv
    
    # print filter results
    while IFS="," read -r rank name platform year remaining
    do
        echo "name: $name"
        echo "platform: $platform"
        echo "year: $year"
        echo ""
    done < <(tail -n +2 filterResults.csv)
    
    # count how many results in total
    echo $(wc -l < filterResults.csv) "results in total"
else
	echo "the filename you entered does not exist"
fi