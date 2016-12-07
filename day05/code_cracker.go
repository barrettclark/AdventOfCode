package main

import (
	"crypto/md5"
	"encoding/hex"
	"fmt"
	"regexp"
	"strconv"
	"strings"
)

func generate_character(prefix string, min int, max int) (int, string) {
	for i := min; i <= max; i++ {
		h := md5.Sum([]byte(prefix + strconv.Itoa(i)))
		hash := (hex.EncodeToString(h[:]))
		match, _ := regexp.MatchString("^0{5}", hash)
		if match {
			return i, hash[5:6]
		}
	}
	return 0, ""
}

func main() {
	// prefix := "abc"
	prefix := "wtnhxymk"
	min := 1
	max := int(1 << 50)
	idx := 0
	var characters [8]string

	for {
		i, character := generate_character(prefix, min, max)
		characters[idx] = character
		fmt.Println(character, characters)
		if characters[7] != "" {
			break
		}
		idx++
		min = i + 1
	}
	fmt.Println(strings.Join(characters[:], ""))
}
