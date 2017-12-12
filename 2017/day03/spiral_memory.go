package main

import (
	"fmt"
	"math"
)

// https://math.stackexchange.com/a/163101
func spiral(n int) (x, y float64) {
	k := math.Ceil((math.Sqrt(float64(n)) - 1) / 2)
	t := float64(2*k + 1)
	m := math.Pow(t, 2)
	f := float64(n)
	t -= 1
	if f >= m-t {
		return k - (m - f), -k
	} else {
		m = m - t
	}
	if f >= m-t {
		return -k, -k + (m - f)
	} else {
		m = m - t
	}
	if f >= m-t {
		return -k + (m - f), k
	}
	return k, k - (m - f - t)
}

func main() {
	n := 265149
	p2, q2 := spiral(n)
	fmt.Printf("%d: %f, %f\n", n, p2, q2)

	distance := int(math.Abs(p2) + math.Abs(q2))
	fmt.Printf("Distance: %d\n", distance)
}
