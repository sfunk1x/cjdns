#! /bin/bash

CJDHOME=/path/to/cjdns
CJDCONF=$CJDHOME/cjdroute.conf
REPORT=~/cjdns-bug-report.txt

#command to execute nodejs code
NODECMD=node    ## for mac or centos
#NODECMD=nodejs   ## IF UBUNTU USE THIS ONE

# get version
echo -e "Version\n===\n" > $REPORT
$CJDHOME/cjdroute -v >> $REPORT

# get git revision
cd $CJDHOME
echo -e "\n\ngit revision\n===\n" >> $REPORT
git rev-parse HEAD >> $REPORT

# get ip address
echo -e "\n\nip address\n===\n" >> $REPORT
ifconfig | grep fc | tr -s [:space:] >> $REPORT

# dump routing table
echo -e "\n\nrouting table\n===\n" >> $REPORT
$NODECMD $CJDHOME/contrib/nodejs/tools/dumptable.js >> $REPORT

# dump peerstats
echo -e "\n\npeerstats\n===\n" >> $REPORT
$NODECMD $CJDHOME/contrib/nodejs/tools/peerStats.js >> $REPORT

# dump pathfinderTree
echo e "\n\npathfinderTree\n===\n" >> $REPORT
$NODECMD $CJDHOME/contrib/nodejs/tools/pathfinderTree.js >> $REPORT

# dump trashroutes
echo -e "\n\ntrashroutes\n===\n" >> $REPORT
$CJDHOME/contrib/python/trashroutes >> $REPORT

# dump graphStats - disabled util I can figure out the unicode issue with graphStats and python and text.
#echo -e "\n\ngraphStats\n===\n" >> $REPORT
#$CJDHOME/contrib/python/graphStats >> $REPORT
