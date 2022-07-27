package main

import (
	"fmt"
//	"flag"
//	"strings"
	"os"
	replace "goDeploy/replace"
	load "goDeploy/load"
	cfg "goDeploy/configure"

)

//var command string
//
//func init() {
//    flag.StringVar(&command,"c","请选要替换的配置：dbscale,mysql","log in user")
//}

func main() {
	var sourcefile string
	var targetfile string
	
//	flag.Parse()

		//加载参数：top文件位置和pid号
	for index,value := range os.Args{
		if index == 1 {
			sourcefile = value
		}
		if index == 2 {
			targetfile = value
		}
	}
	
	if sourcefile == "" || targetfile == ""{
		fmt.Println("使用方法： ./goChcfg 当前配置 要同步的现场配置")
	}else{
		//开始读取配置文件
		var sourcecfg = load.Loadsourcecfg(sourcefile)
		var targetcfg = load.Loadtargetcfg(targetfile)
		
		//定义需要的配置项数组或变量
		var newcfglist = replace.ReplaceCfg(sourcecfg, targetcfg)
		
		cfg.RepDBSCALEcfg(newcfglist)
	}
	
	
	
}