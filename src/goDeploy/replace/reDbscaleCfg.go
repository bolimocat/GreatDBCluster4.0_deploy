package replace

import (
//	"fmt"
	"strings"
//	"strconv"
)


func ReplaceCfg(sourcecfg []string,targetcfg []string) []string{
		var newcfglist []string = make([]string,0)
		var sourcelist []string = make([]string,0)
		var targetlist []string = make([]string,0)
		var sourceline int
		var targetline int

		
		for index,value := range sourcecfg {
		sourcelist = append(sourcelist,value)
		if strings.Contains(value, "[driver mysql]"){
			sourceline = index
		}
	}
		for index,value := range targetcfg {
		targetlist = append(targetlist,value)
		if strings.Contains(value, "[driver mysql]"){
			targetline = index
		}
	}
		//当前集群的密码和IP部分
		for index,value := range  sourcecfg{
			if index < sourceline{
				if strings.Contains(value, "admin-password =") || strings.Contains(value, "log-file =") || strings.Contains(value, "cluster-password = ") || strings.Contains(value, "node-host-addr = ") || strings.Contains(value, "zk-log-file = ") || strings.Contains(value, "zookeeper-host = ") {
					newcfglist = append(newcfglist,value)
				}
			}
		
	}
	
	for index,value := range  targetcfg {
		if index < targetline {
			if strings.Contains(value, "[main]") || strings.Contains(value, "admin-password =") || strings.Contains(value, "log-file =") || strings.Contains(value, "cluster-password = ") || strings.Contains(value, "node-host-addr =") || strings.Contains(value, "zk-log-file = ") || strings.Contains(value, "zookeeper-host = ") {
			}else{
				newcfglist = append(newcfglist,value)
			}
		}
			
	
	}
	
	//当前集群的节点分布情况
	for index,value := range  sourcecfg {
		if index >= sourceline {
			newcfglist = append(newcfglist,value)
		}
	}
		
	
		return newcfglist
}
