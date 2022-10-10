#! /usr/bin/env bash

echo "enter your csv filename"
read filename
if [ -e "$filename" ]
then
    #truncating data
    echo "truncating data"
    head -n 3 $filename > truncatingResults.txt
    #cut -d',' -f2 $filename > truncatingResults.txt
    echo ""
    
    # sort by years
    echo "sort by year"
    sort -nr -t ',' -k4 $filename > sortResults1.csv
    echo ""
    
    # delete rows that contains ""
    echo "clean data"
    sed '/"/d' $filename > cleanResults.csv
    #sed -i -e '/""/d' $filename
    echo "" 

    # sort by years
    echo "sort by year again"
    sort -nr -t ',' -k4 cleanResults.csv > sortResults2.csv
    echo ""

    # filter and save as csv file
    echo "ETL"
	echo "enter your key word for filtering"
	read keyword
	grep -i $keyword $filename > filterResults.csv
    
    # print filter results
    while IFS="," read -r rank name platform year remaining
    do
        echo "name: $name"
        echo "platform: $platform"
        echo "year: $year"
        echo ""
    done < <(tail -n +2 filterResults.csv)
    
    # count how many results in total
    echo $(wc -l < filterResults.csv) "filter results in total"
else
	echo "the filename you entered does not exist"
fi