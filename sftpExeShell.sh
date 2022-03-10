#!/bin/bash
dir=/home/esb/sftp+expect
srcdir=/home/esb/esblog
tmpdir=/home/esb/esb_log
destdir=/home/esb/back
$dir/packLog.sh $srcdir $tmpdir
filename=`cut -f 1 packLog.sh.log`
while read line
do
host=`echo $line| awk '{print $1}'`
user=`echo $line | awk '{print $2}'`
passwd=`echo $line | awk '{print $3}'`
$dir/cpExeShell.sh $host $user $passwd $tmpdir $destdir $filename
done < $dir/host.txt
$dir/delTmp.sh $tmpdir
