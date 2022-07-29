# expect.ahk
A Test Anything Protocol (TAP) compliant unit testing package for AutoHotkey

## Installation

In a terminal or command line navigated to your project folder:
```bash
npm install expect.ahk
```

In your code only export.ahk needs to be included:

```autohotkey
#Include %A_ScriptDir%\node_modules
#Include expect\export.ahk
expect := new expect()

testVar := 2 + 2
expect.equal(testVar, 4)
expect.fullReport()
```
You may also review or copy the library from [./export.ahk on GitHub](https://github.com/Chunjee/expect.ahk); #Include as you would normally when manually downloading.


## Usage

Grants access to a class named `expect` with the following methods: `.equal`, `.notEqual`, `.true`, `.false`, `.label`, `.group`, `.report`, `.fullReport`, and `.writeTestResultsToFile`

```autohotkey
expect := new expect()

; .equal checks and logs whether or not both arguments are the same
expect.label("string comparison")
expect.equal("StringExample", "StringExample")

expect.label("value testing")
expect.equal((1 > 0 ), true)

expect.label("true/false testing")
expect.true((1 == 1))
expect.false((1 != 1))
expect.notEqual(true,false)

expect.report()
expect.fullReport()
expect.writeTestResultsToFile()
```

## API

### .equal(actual, expected)

Alias: `.test`

checks if actual and expected are the same or equal. The comparison is case-insensitive when ahk is `inStringCaseSense, Off` (default ahk behavior)

##### Arguments
1. actual (*): The actual value computed
2. expected (*): The expected value

##### Returns
(boolean): returns true if the values were the same, else false

##### Example
```autohotkey
expect.equal("string", "tsring")
; => false

expect.equal((1 > 0 ), true)
; => true
```


### .true(actual)
checks if actual value is true.

##### Arguments
1. actual (*): The actual value computed

##### Returns
(boolean): returns true if the value is true, else false

##### Example
```autohotkey
expect.true((1 == 1))
; => true

expect.true(InStr("String", "S"))
; => true
```


### .false(actual)
checks if actual value is false.

##### Arguments
1. actual (*): The actual value computed

##### Returns
(boolean): returns true if the value is false, else false

##### Example
```autohotkey
expect.false((1 != 1))
; => true

expect.false(InStr("String", "X"))
; => true
```


### .notEqual(actual, expected)
checks if actual and expected are NOT the same or equal. The comparison is case-insensitive when ahk is `inStringCaseSense, Off` (default ahk behavior)

##### Arguments
1. actual (*): The actual value computed
2. expected (*): The expected value

##### Returns
(boolean): returns true if the value is false, else false

##### Example
```autohotkey
expect.notEqual((1 != 1))
; => true

expect.notEqual(InStr("String", "X"))
; => true
```


### .undefined(actual)
checks if actual is undefined (`""`).

##### Arguments
1. actual (*): The actual value computed

##### Returns
(boolean): returns true if the value is `""`, else false

##### Example
```autohotkey
expect.false((1 != 1))
; => true

expect.false(InStr("String", "X"))
; => true
```


### .label(label)
labels the following tests for logs and readability

##### Arguments
1. label (string): A human readable label for the next test(s) in sequence


##### Example
```autohotkey
expect.label("string comparisons")

expect.equal("String", "s")
expect.fullReport()
/*---------------------------
1 tests completed with 0% success (1 failure)
=================================
== string comparisons ==
Test Number: 1
Expected: s
Actual: String
---------------------------*/
```

### .group(label)
appends the label to a group of following tests for logs and readability

This may be useful when one has a lot of tests; and doesn't want to type out a repeatative label

##### Arguments
1. label (string): A human readable label prepend for the next test(s) in sequence


##### Example
```autohotkey
expect.group("strings")
expect.label("comparison")
expect.equal("String", "s")

expect.label("length")
expect.equal(strLen("String"), 9)

expect.fullReport()
/*---------------------------
2 tests completed with 0% success (2 failures)
=================================
== strings - comparisons ==
Test Number: 1
Expected: s
Actual: String

== strings - length ==
Test Number: 2
Expected: 99
Actual: 6
---------------------------*/
```


### .report()
Uses msgbox to display the results of all tests

##### Example
```autohotkey
expect.true(InStr("String", "S"))

expect.report()
/*---------------------------
1 test completed with 100% success
---------------------------*/
```


### .fullReport()
Uses msgbox to display the results of all tests with details of any failures

##### Example
```autohotkey
expect.true(InStr("String", "X"))

expect.fullReport()
/*---------------------------
1 tests completed with 0% success (1 failure)
=================================
Test Number: 1
Expected: true
Actual: false
---------------------------*/
```


### .writeResultsToFile([filepath, fileopen])
writes test results to a file

##### Arguments
1. filepath (string): Optional, The file path to write all tests results to, the default is `A_ScriptDir "\result.tests.log"`

2. fileopen (bool): Optional, Open the file if true. Default: false

##### Example
```autohotkey
expect.true(InStr("String", "X"))

expect.writeTestResultsToFile()
/*
1 test completed with 0% success (1 failure)

Test Number: 1
Expected: true
Actual: false*/
```
