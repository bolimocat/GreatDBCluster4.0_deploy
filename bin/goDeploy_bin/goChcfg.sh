#!/bin/bash
#加载登录信息
while read line
do
	if [[ $line =~ "USER" ]]
	then
    	#echo "user name  :"$line
    	name=(`echo $line|cut -d \= -f 1` `echo $line|cut -d \= -f 2`)
    	echo "user name : "${name[1]}
	fi
	if [[ $line =~ "PASSWORD" ]]
	then
		password=(`echo $line|cut -d \= -f 1` `echo $line|cut -d \= -f 2`)
    	echo "user password  :"${password[1]}
	fi
	if [[ $line =~ "DBSCALE_HOST" ]]
	then
		dbscale_host=(`echo $line|cut -d \= -f 1` `echo $line|cut -d \= -f 2`)
		host=(`echo ${dbscale_host[1]}|cut -d \, -f 1` `echo ${dbscale_host[1]}|cut -d \, -f 2`)
    	echo "dbscale host  :"${host[0]}
	fi
	
	if [[ $line =~ "BASE_PATH" ]]
	then
    	basepath=(`echo $line|cut -d \= -f 1` `echo $line|cut -d \= -f 2`)
    	echo "basepath : "${basepath[1]}
	fi
	if [[ $line =~ "DBSCLPTH" ]]
	then
    	dbsclpth=(`echo $line|cut -d \= -f 1` `echo $line|cut -d \= -f 2`)
    	echo "dbsclpth : "${dbsclpth[1]}
	fi
	
done < file/properties

echo '在线替换现场dbscale配置'

echo '停止所有dbscale进程'
#./goDbscaleService -c stop
sleep 5



echo '备份现有dbscale.conf  '${basepath[1]}${dbsclpth[1]}
#ssh ${host[0]} "mv "${basepath[1]}${dbsclpth[1]}"/dbscale/dbscale.conf "${basepath[1]}${dbsclpth[1]}"/dbscale/dbscale.conf.back"

echo '依据最新现场配置生成替换文件'
./goChcfg file/pe/dbscale_192.168.2.21.conf file/pe/dbscale.xianchang.conf

echo '上传替换文件'
scp -r file/pe/dbscale.conf root@${host[0]}:${basepath[1]}${dbsclpth[1]}/dbscale/dbscale.conf.xianchang
ssh  ${host[0]} "chown -R "${name[1]}":"${name[1]}" "${basepath[1]}${dbsclpth[1]}/dbscale/dbscale.conf.xianchang

echo 'clean the zk buffer'
#ssh ${host[0]}  "export LD_LIBRARY_PATH="${basepath[1]}${dbsclpth[1]}"/dbscale/libs/:$LD_LIBRARY_PAHT; "${basepath[1]}${dbsclpth[1]}"/dbscale/clean_zookeeper "${host[0]}" 2181; "${basepath[1]}${dbsclpth[1]}"/dbscale/daemon/dbscale_daemon.py; "${basepath[1]}${dbsclpth[1]}"/dbscale/daemon/dbscale_daemon_stop.py"
sleep 2

echo '重启所有dbscale进程'
#./goDbscaleService -c start