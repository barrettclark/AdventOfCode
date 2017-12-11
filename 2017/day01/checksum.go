package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {
	dat, err := ioutil.ReadFile("input1.txt")
	check(err)
	line := strings.TrimSuffix(string(dat), "\n")
	chars := strings.Split(line, "")
	checksum := 0
	nextNumber := -1
	for i, char := range chars {
		currentNumber, _ := strconv.Atoi(char)
		if i < len(line)-1 {
			nextNumber, _ = strconv.Atoi(chars[i+1])
		} else {
			nextNumber, _ = strconv.Atoi(chars[0])
		}
		if currentNumber == nextNumber {
			checksum += nextNumber
		}
		// fmt.Printf("%d: Current: %d, Next: %d, Checksum: %d\n", i, currentNumber, nextNumber, checksum)
	}
	fmt.Printf("Checksum: %d\n", checksum)
}
