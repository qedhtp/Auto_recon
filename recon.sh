#!/bin/bash

#echo "Creating directory $1_recon. Let's go!"
#today=$(date)
#echo "This is scan was created on $today"


# echo help
# if [$domain == "-h"]
# then
# echo "enter ./recon.sh tool_name to use"
# Select which tool to run
# echo "this is test"
nmap_scan()
{
    # nmap scan
    nmap $domain > $directory/nmap.txt
    echo "The results of nmap scan are stored in $directory/nmap.txt"
}
dirsearch_scan()
{
    # dirsearch bruteforce
    dirsearch.py -u $domain -o $directory/dirsearch.txt
    echo "The results of dirsearch are stored in $directory/dirsearch.txt"
}
sub_scan()
{
    # subfinder
    subfinder -d $domain -o $directory/subfinder.txt
    echo "The results of subfinder are stored in $directory/subfinder.txt"

    # amass
    amass enum -passive -norecursive -d $domain -o $directory/amass.txt
    echo "The results of amass are stored in $directory/amass.txt"

    # crt
    curl "https://crt.sh/?q=$domain&output=json" | jq -r ".[] | .name_value" >> $directory/crt.txt
    echo "The results of crt are stored in $directory/crt.txt"
}     

getopts "m:" OPTION
mode=$OPTARG
for i in "${@:$OPTIND:$#}"
do 
    domain=$1
    directory=${domain}_recon
    echo "Creating directory $DIRECTORY."
    mkdir $domain_recon
    case $MODE in
        nmap_only)
            nmap_scan
            ;;
        dirsearch_only)
            dirsearch_scan
            ;;
        sub_only)
            sub_scan
            ;;
        crt_only)
            crt_scan
            ;;
        *)
            nmap_scan
            dirsearch_scan
            sub_scan
            crt_scan
            ;; 
    esac

    echo "Generating recon report from output files..."
    
    echo "This scan was created on $today" > $directory/report.txt
    echo "Results for nmap:" >> $directory/report.txt
    grep -E "^\s*\S+\s+\S+\s+\s*$" $directory/nmap.txt >> $directory/report.txt
    echo "Results for Dirsearch:" >> $dirsearch/report.txt
    cat $directory/dirsearch.txt >> $directory/report.txt
    echo "Results for subdomain" >> $directory/report.txt
    cat $directory/sub_all.txt >> $directory/report.txt


