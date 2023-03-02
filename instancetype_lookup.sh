#!/bin/bash
#This script will search all aws regions that your account has access to for a given instance type.  I use it to confirm if an instance
#+ type is available in all regions.  To use it, replace the instance type on line 11 with whatever you are looking for.  You must have
#+ aws cli installed and configured ($aws configure).  NOTE: This script is slow.

readarray -t region_check <<< $(aws ec2 describe-regions | grep 'RegionName.*' | cut -c 15-)

for i in ${region_check[@]}
do
    echo "$i"
    aws ec2 describe-instance-types --instance-types --region $i | grep 'InstanceType: m5d.xlarge'
done
exit
