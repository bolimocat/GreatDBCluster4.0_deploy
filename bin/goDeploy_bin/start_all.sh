#!/bin/bash
echo "Let the cluster4 launch ... ..."
#./goDeploy
./goZkService -c start
#./goZkService -c init
#./goMysqlService -c init
./goMysqlService -c startall
#./goMysqlService -c updateuser
./goDbscaleService -c start
echo "The Cluster4 is launched!"


#echo 'Grant all on *.* to root'
#ssh 192.168.2.21 "mysql -uroot -p123456 -h127.0.0.1 -P16310 -e \"grant all on *.* to root@'%' \" "
#echo 'dbscale dynamic add normal_table dataspace test.sbtest0 datasource = "global_ds";'
#ssh 192.168.2.21 "mysql -uroot -p123456 -h192.168.2.21 -P16310 -e \" dbscale dynamic add normal_table dataspace test1.tb_1 datasource = 'global_ds'; \" "
