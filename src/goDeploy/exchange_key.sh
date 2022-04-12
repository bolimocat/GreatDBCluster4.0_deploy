#EverDB auto deploy suit by SHELL
#Write by Lming 2021.08.27

#!/bin/bash
echo "交换key"
source ./properties.sh
array_node=(`echo $ALL_HOST|cut -d \, -f 1` `echo $ALL_HOST|cut -d \, -f 2` `echo $ALL_HOST|cut -d \, -f 3` `echo $ALL_HOST|cut -d \, -f 4` `echo $ALL_HOST|cut -d \, -f 5` `echo $ALL_HOST|cut -d \, -f 6`)
cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

echo "交换所有节点的root用户key"
for((i=0;i<$NODE_NUM;i++))
	do
		echo "交换 ${array_node[i]} 的root密码"
		ssh root@${array_node[i]} "rm -rf /root/.ssh;ssh-keygen -t rsa"
		ssh root@${array_node[i]} "cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys"
		scp -r /root/.ssh/authorized_keys root@${array_node[i]}:/root/.ssh
		scp -r /root/.ssh/known_hosts root@${array_node[i]}:/root/.ssh
	done

