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

Grants access to a class named `expect` with the following methods: `.equal`, `.notEqual`, `.true`, `.false`, `.undefined`, `.group`, `.label`, `.report`, `.fullReport`, and `.writeResultsToFile`

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
expect.writeResultsToFile()
```
