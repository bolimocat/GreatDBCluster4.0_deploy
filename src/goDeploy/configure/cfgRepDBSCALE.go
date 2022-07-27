package configure

import (
	"os"
	"fmt"
	
)

func RepDBSCALEcfg(newcfglist []string){
	
	
	f, err := os.OpenFile("./file/pe/dbscale.conf", os.O_CREATE|os.O_WRONLY, 0644)
	defer f.Close()
	if err != nil {
		fmt.Println(err.Error())
	} else {
		fmt.Println("start change dbscale cfg")
		f.Write([]byte("[main]\n"))
		for _,value := range newcfglist{
			f.Write([]byte(value+"\n"))
		}
	}
}