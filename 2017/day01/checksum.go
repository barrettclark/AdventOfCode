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
	dat, err := ioutil.ReadFile("input2.txt")
	check(err)
	line := strings.TrimSuffix(string(dat), "\n")
	chars := strings.Split(line, "")
	length := len(chars)
	offset := length / 2
	checksum := 0
	nextNumber := -1
	nextPosition := -1
	for i, char := range chars {
		currentNumber, _ := strconv.Atoi(char)
		nextPosition = offset + i
		if nextPosition > length-1 {
			nextPosition = nextPosition - length
		}
		nextNumber, _ = strconv.Atoi(chars[nextPosition])
		if currentNumber == nextNumber {
			checksum += nextNumber
		}
		// fmt.Printf("%d: Current: %d, Next: %d, Checksum: %d\n", i, currentNumber, nextNumber, checksum)
	}
	fmt.Printf("Checksum: %d\n", checksum)
}
