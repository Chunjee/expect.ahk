<div align="center">
	<a href="https://github.com/Chunjee/expect.ahk">
		<img src="https://raw.githubusercontent.com/Chunjee/expect.ahk/master/header.svg"/></a>
	<br>
	<br>
	<a href="https://npmjs.com/package/expect.ahk">
		<img src="https://img.shields.io/npm/dm/expect.ahk?style=for-the-badge"></a>
	<a href="https://chunjee.github.io/expect.ahk">
		<img src="https://img.shields.io/badge/full-documentation-blue?style=for-the-badge"></a>
	<img src="https://img.shields.io/npm/l/expect.ahk?color=tan&style=for-the-badge">
	<h3>
		A Test Anything Protocol (TAP) compliant unit testing package for AutoHotkey
	</h3>
</div>

## Installation

In a terminal or command line navigated to your project folder:
```bash
npm install expect.ahk
```

In your code only the file export.ahk needs to be included:

```autohotkey
#Include %A_ScriptDir%\node_modules
#Include expect.ahk\export.ahk
expect := new expect()

testVar := 2 + 2
expect.equal(testVar, 4)
expect.fullReport()
```
You may also review or copy the library from [./export.ahk on GitHub](https://github.com/Chunjee/expect.ahk); #Include as you would normally when manually downloading.


## Usage

Grants access to a class named `expect` with the following methods: `.equal`, `.notEqual`, `.true`, `.false`, `.label`, `.group`, `.report`, `.fullReport`, and `.writeResultsToFile`

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


# Contributing

We kindly ask those interested to submit their contributions in the form of a pull request. Your efforts are sincerely appreciated. Thank you for your valuable contributions!


# API

## .equal
> `expect.equal([1, 2, 3], [1, 2, 3])`

checks if param_actual and param_expected inputs are the same or equal. The comparison is always case-sensitive.
#### Aliases
`.test`


#### Arguments
| Argument       | Type         | Description  |
| :------------- | :----------- | :----------- |
| param_actual | number/string/object | The actual value. |
| param_expected | number/string/object | The expected value. |
| param_note | string | (Optional) Additional notes for the test. |



#### Returns
(boolean): Returns true if the values are equal, else false.

<!-- end of .equal -->




## .notEqual
> `expect.notEqual({ "a":1 }, { "a":false })`

checks if actual and expected inputs are NOT the same or equal. The comparison is always case-sensitive.


#### Arguments
| Argument       | Type         | Description  |
| :------------- | :----------- | :----------- |
| param_actual | number/string/object | The actual value computed. |
| param_expected | number/string/object | The expected value. |
| param_note | string | Additional notes for the test (Optional). |


#### Returns
(boolean): Returns true if the values are different, else false.

<!-- end of .notEqual -->




## .true
> `expect.true((1 == 1))`

checks if actual value is true.


#### Arguments
| Argument       | Type         | Description  |
| :------------- | :----------- | :----------- |
| param_actual | number/string | The actual value computed. |
| param_note | string | Additional notes for the test (Optional). |


#### Returns
(boolean): Returns true if the values are different, else false.

<!-- end of .true -->




## .false
> `expect.false((99 < 3))`

checks if actual input is false.


#### Arguments
| Argument       | Type         | Description  |
| :------------- | :----------- | :----------- |
| param_actual | number/string/object | The actual value computed. |
| param_note | string | Additional notes for the test (Optional). |


#### Returns
(boolean): returns true if the value is false, else false

<!-- end of .false -->




## .undefined
> `expect.undefined("")`

checks if actual is undefined (`""`).


#### Arguments
| Argument       | Type         | Description  |
| :------------- | :----------- | :----------- |
| param_actual | number/string | The actual value computed. |
| param_note | string | Additional notes for the test (Optional). |


#### Returns
(boolean): returns true if the value is `""`, else false

<!-- end of .undefined -->




## .group
> `expect.group("Object Tests")`

appends the label to a group of following tests for logs and readability


#### Arguments
| Argument       | Type         | Description  |
| :------------- | :----------- | :----------- |
| param_label | string | A human readable label prepend for the next test(s) in sequence |


<!-- end of .group -->




## .label
> `expect.label("myInterestingLabel")`

labels the following tests for logs and readability


#### Arguments
| Argument       | Type         | Description  |
| :------------- | :----------- | :----------- |
| param_label | string | A human readable label for the next test(s) in sequence |


<!-- end of .label -->




## .writeResultsToFile
> `expect.writeResultsToFile(".\myLogFile.tap")`

Writes the report to a file and optionally opens the file.


#### Arguments
| Argument       | Type         | Description  |
| :------------- | :----------- | :----------- |
| param_filepath | string | The path of the file where the report will be written. If not provided, the default logResultPath will be used. |



#### Returns
(string): The report that was written to the file.

#### Exceptions
(Throws exception): If there is an error writing the report to the disk.
<!-- end of .writeResultsToFile -->




## .report
> `expect.report()`

returns the full test results. This should be used with to integrate with Continuous Integration (CI) Systems


#### Arguments
Does not accept any arguments.


#### Returns
(string): returns a string containing all the test results.

<!-- end of .report -->




## .fullReport
> `expect.fullReport()`

Uses msgbox to display the results of all tests with details of any failures


#### Arguments
Does not accept any arguments.


#### Returns
(string): The generated full report message.

<!-- end of .fullReport -->
