#!/bin/bash
echo "Creating directory $1_recon. Let's go!"
today=$(date)
echo "This is scan was created on $today"
domain=$1
directory=${domain}_recon
mkdir $1_recon

# echo help
# if [$domain == "-h"]
# then
# echo "enter ./recon.sh tool_name to use"
# Select which tool to run
# echo "this is test"
if [ $2 == "nmap-only" ]
then
    # nmap scan
    nmap $1 > $directory/nmap.txt
    echo "The results of nmap scan are stored in $directory/nmap.txt"
elif [$2 == "dirsearch"]
then
    # dirsearch bruteforce
    dirsearch.py -u $1 -o $directory/dirsearch.txt
    echo "The results of dirsearch are stored in $directory/dirsearch.txt"
elif [$2 == "sub"]
then
    # subfinder
    subfinder -d $1 -o $directory/subfinder.txt
    echo "The results of subfinder are stored in $directory/subdinder.txt"

    # amass
    amass enum -passive -norecursive -d $1 -o $directory/amass.txt
    echo "The results of amass are stored in $directory/amass.txt"
fi