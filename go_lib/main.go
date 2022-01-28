package main

import (
	"C"
	"fmt"
)

func main() {}

//export greet
func greet(name *C.char) *C.char {
	nameStr := C.GoString(name)
	return C.CString(fmt.Sprintf("Hello %s!", nameStr))
}
