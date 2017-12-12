package main

import (
	"bufio"
	"fmt"
	"log"
	"math"
	"os"
	"sort"
	"strconv"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func numbersFromLine(line string) (numbers []int) {
	numberStrings := strings.Split(line, "\t")
	for _, s := range numberStrings {
		currentNumber, _ := strconv.Atoi(s)
		numbers = append(numbers, currentNumber)
	}
	return
}

func sortedMod(n1 int, n2 int) float64 {
	floats := []float64{float64(n1), float64(n2)}
	sort.Float64s(floats)
	return math.Mod(floats[1], floats[0])
}

func sortedDiv(n1 int, n2 int) int {
	ints := []int{n1, n2}
	sort.Ints(ints)
	return ints[1] / ints[0]
}

func main() {
	file, err := os.Open("input2.txt")
	check(err)
	defer file.Close()

	scanner := bufio.NewScanner(file)
	checksum := 0
	for scanner.Scan() {
		numbers := numbersFromLine(scanner.Text())
		for _, currentNumber := range numbers {
			for _, compareNumber := range numbers {
				if currentNumber <= compareNumber {
					continue
				} else if sortedMod(currentNumber, compareNumber) == 0 {
					chk := sortedDiv(currentNumber, compareNumber)
					checksum += chk
					// fmt.Println(currentNumber, compareNumber, chk)
				}
			}
		}
		// fmt.Printf("Line: %v, Checksum: %d\n", numbers, checksum)
	}
	fmt.Println(checksum)
	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}
