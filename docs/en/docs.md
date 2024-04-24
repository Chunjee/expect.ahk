#
# **Check methods**

## .equal
> `expect.equal([1, 2, 3], [1, 2, 3])`

checks if `param_actual` and `param_expected` inputs are equal. The comparison is always case-sensitive.
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

checks if `param_actual` and `param_expected` inputs are NOT equal. The comparison is always case-sensitive.


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

checks if `param_actual` value is true.


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

checks if `param_actual` input is false.


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

checks if `param_actual` is undefined (`""`).


#### Arguments
| Argument       | Type         | Description  |
| :------------- | :----------- | :----------- |
| param_actual | number/string | The actual value computed. |
| param_note | string | Additional notes for the test (Optional). |


#### Returns
(boolean): returns true if the value is `""`, else false

<!-- end of .undefined -->



# **Grouping methods**
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



# **Log methods**
## .writeResultsToFile
> `expect.writeResultsToFile(".\myLogFile.tap")`

Writes the report to a file.


#### Arguments
| Argument       | Type         | Description  |
| :------------- | :----------- | :----------- |
| param_filepath | string | The path of the file where the report will be written. If not provided, the default logResultPath will be used. |



#### Returns
(string): The report that was written to the file.

#### Exceptions
(Throws exception): If there is an error writing the report to the disk.
<!-- end of .writeResultsToFile -->



# **Report methods**
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
