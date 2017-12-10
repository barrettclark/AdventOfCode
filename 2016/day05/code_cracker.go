package main

import (
	"crypto/md5"
	"encoding/hex"
	"fmt"
	"regexp"
	"strconv"
	"strings"
)

func generate_character(prefix string, min int, max int) (int, int, string) {
	var h [16]byte
	var hash string
	var match bool
	var position int
	var character string
	for i := min; i <= max; i++ {
		h = md5.Sum([]byte(prefix + strconv.Itoa(i)))
		hash = (hex.EncodeToString(h[:]))
		match, _ = regexp.MatchString("^0{5}[0-7]", hash)
		if match {
			position, _ = strconv.Atoi(hash[5:6])
			character = hash[6:7]
			fmt.Println(i, hash, position, character)
			return i, position, character
		}
	}
	return 0, -1, ""
}

// "trivial" yet super specific array contains function
// http://stackoverflow.com/questions/10485743/contains-method-for-a-slice
func contains(s [8]string, e string) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}

func main() {
	// prefix := "abc"
	prefix := "wtnhxymk"
	min := 1
	max := int(1 << 50)
	var characters [8]string

	for {
		i, idx, character := generate_character(prefix, min, max)
		if characters[idx] == "" {
			characters[idx] = character
			fmt.Println(character, characters)
			if contains(characters, "") == false {
				break
			}
		}
		min = i + 1
	}
	fmt.Println(strings.Join(characters[:], ""))
}
