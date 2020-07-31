package main

import (
	"fmt"
	"os"
)

func main() {
	fmt.Printf("args count: %d\n", len(os.Args))
	fmt.Printf("args      : ")
	var str string
	for i, v := range os.Args {
		if i != 0 {
			str += " "
		}
		str += fmt.Sprintf("%s", v)
	}
	fmt.Printf("%s\n", str)
}
