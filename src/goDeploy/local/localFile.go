//
package local

import (
	 "fmt"
    "os/exec"
)

//操作本地文件
func Mvlocalfile(sourcefile string,targetfile string){
	command := "mv "+sourcefile+" "+targetfile
	cmd := exec.Command("/bin/bash", "-c", command)

    output, err := cmd.Output()
    if err != nil {
        fmt.Printf("Execute Shell:%s failed with error:%s", command, err.Error())
        return
    }
    fmt.Printf("Execute Shell:%s finished with output:\n%s", command, string(output))
}