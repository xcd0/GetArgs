package main

import (
	"fmt"
	"log"
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

	if err := writeLine("args.txt", str); err != nil {
		log.Fatalf("error : %v\n", err)
	}
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
