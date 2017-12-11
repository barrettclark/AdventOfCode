package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {
	// file, err := os.Open("example1.txt")
	file, err := os.Open("input1.txt")
	check(err)
	defer file.Close()

	scanner := bufio.NewScanner(file)
	checksum := 0
	MinInt := int(^uint(0) >> 1)
	MaxInt := -MinInt
	for scanner.Scan() {
		line := scanner.Text()
		numbers := strings.Split(line, "\t")
		min := MinInt
		max := MaxInt
		for _, n := range numbers {
			currentNumber, _ := strconv.Atoi(n)
			if currentNumber < min {
				min = currentNumber
			}
			if currentNumber > max {
				max = currentNumber
			}
		}
		checksum += max - min
		// fmt.Printf("Line: %s, Min: %d, Max: %d, Checksum: %d\n", line, min, max, checksum)
	}
	fmt.Println(checksum)
	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}
