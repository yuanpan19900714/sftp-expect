#!/bin/bash
logdir=$1
tmpdir=$2

LogBackup(){
#LogBackup函数调用说明
#调用模版: LogBackup /SourceDir /DestDir 5 ESB
#参数说明
#参数1:备份源路径
#参数2:备份目标路径
#参数3:截止现在时间的间隔,以天数计算
#参数4:前缀文件名
#备注:备份文件名按”前缀+当前日期+机器名"的方式生成
	CurrentPath=`pwd`
	if [ ! 5 -eq "$#" ]; then
	   #echo "LogBackup函数输入参数数量不为5" > "$0.log"
	   return 1
	fi
	#echo "备份源目录:" $1 > "$0.log"
	#echo "备份目标目录:" $2 >> "$0.log"
	#echo "备份时间间隔:" $3 >> "$0.log"
	#echo "备份文件名前缀:" $4 >> "$0.log"
	#echo "备份机器名:" $5 >> "$0.log"
#查看备份源目录是否存在
	if [ ! -d "$1" ]; then
	    #echo "备份源目录:" "$1" "不存在" > "$0.log"
	    return 1
	fi
#查看备份目标目录是否存在
	if [ ! -d "$2" ]; then
	    #echo "备份目标目录:" "$2" "不存在" > "$0.log"
	    return 1
	fi
#天数整数判断
	#if [[ "$3" =~ "^[0-9]+$" ]]; then
		##echo "特殊处理间隔天数[" $3 "]非数字" > "$0.log"
	   #return 1
	#fi
#保存现场
	SourceDir=$1	#备份源目录名
	DestDir=$2		#备份目标目录名
	DateSpit=$3		#备份时间间隔
	FileNamePre=$4	#备份文件名前缀
	CurrentDate=`date -d "$DateSpit days ago" "+%Y-%m-%d"`
	MachineName=$5
	DestFullFileName="$DestDir/$MachineName/$FileNamePre$CurrentDate.tar.zip"
	FileList=`find $SourceDir -type f -mtime +$DateSpit`
	FileList_EQ_DAY=`find $SourceDir -type f -mtime $DateSpit`
	#判断源目录中备份时间间隔之前的文件是否存在
	if [ -z "$FileList_EQ_DAY" ]; then
	    #echo `date "+%Y-%m-%d %H:%M:%S"`"--备份源目录:" "$1" "中$CurrentDate及之前的文件不存在" >> "$0.log"
	    return 1
	fi
	mkdir -p $DestDir/$MachineName/
	tar -zcvf $DestFullFileName $FileList_EQ_DAY

	for specfileloop in `find $SourceDir -empty -type d -name '20[0-9][0-9][0-9][0-9][0-9][0-9]'`
	do 
	    #echo "删除空文件夹:" $specfileloop >> "$0.log"
	    rm -rf $specfileloop
	done	
	#echo `date "+%Y-%m-%d %H:%M:%S"`": 备份成功,文件名为:["$DestFullFileName"]" >> "$0.log"

	#return 0
	echo "$DestFullFileName" > "$0.log"
}
LogBackup $logdir $tmpdir 1 ESB AP1
