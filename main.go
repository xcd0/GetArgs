package main

import (
	"fmt"
	"log"
	"os"
	"os/user"
	"path/filepath"
)

func main() {
	var str string
	var fpath string

	u, err := user.Current()
	if err == nil {
		str += fmt.Sprintf("user home dir: %s\n", u.HomeDir)
	}

	curr, err := os.Getwd()
	if err == nil {
		str += fmt.Sprintf("current dir  : %s\n", curr)
	}

	str += fmt.Sprintf("args count   : %d\n", len(os.Args))
	str += fmt.Sprintf("args         : ")
	for i, v := range os.Args {
		if i != 0 {
			str += " "
		}
		str += v
	}
	str += "\n"
	fmt.Printf("%s", str)

	//fpath = filepath.FromSlash(curr + "/args.txt")
	fpath = filepath.FromSlash(u.HomeDir + "/args.txt")

	if err := writeLine(fpath, str); err != nil {
		log.Fatalf("error : %v\n", err)
	}

	os.Getwd()
}

func writeLine(filename string, line string) error {
	file, err := os.Create(filename)
	if err != nil {
		return err
	}
	defer file.Close()

	if _, err := file.WriteString(line); err != nil {
		return err
	}
	return nil
}
