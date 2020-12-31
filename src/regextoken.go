package main

import "C"
import (
    "log"
    "encoding/json"
    "github.com/google/codesearch/index"
    "github.com/google/codesearch/regexp"
)

    //export tokens
    func tokens(pat string) *C.char {
        re, err := regexp.Compile(pat)
        if err != nil {
            log.Printf("Error Parsing regexp", err)
            return C.CString(string(""))
        } else {
            q := index.RegexpQuery(re.Syntax)

            log.Printf("The trigram query :: ",  pat,  q)
            j, err := json.Marshal(q)
            _ = err
            return C.CString(string(j))
        }
    }

    func main() {
        tokens("^(?m) progra m|will$")
    }
