class expect {
	__New() {
		this.testTotal := 0
		this.failTotal := 0
		this.successTotal := 0
		this.log := []
		this.groupVar := ""
		this.labelVar := ""
		this.lastlabel := ""
		this.finalTrigger := false
	}
	/**
	* checks if `param_actual` and `param_expected` inputs are equal. The comparison is always case-sensitive.
	* @param {number|string|object} param_actual - The actual value.
	* @param {number|string|object} param_expected - The expected value.
	* @param {string} param_note - (Optional) Additional notes for the test.
	*
	* @returns {boolean} Returns true if the values are equal, else false.
	*
	* @example expect.equal([1, 2, 3], [1, 2, 3])
	*
	* @alias .test
	* @example
	* ### Example usage
	* You can use like so:
	* ```autohotkey
	* expect.equal(inStr("String", "ing"), 4)
	* ```
	*/
	equal(param_actual:="_Missing_Parameter_", param_expected:="_Missing_Parameter_", param_note:="") {
		if (A_IsCompiled) {
			return 0
		}
		; create
		return this.test(param_actual, param_expected, param_note)
	}
	/**
	* checks if `param_actual` and `param_expected` inputs are NOT equal. The comparison is always case-sensitive.
	* @param {number|string|object} param_actual - The actual value computed.
	* @param {number|string|object} param_expected - The expected value.
	* @param {string} param_note - Additional notes for the test (Optional).
	*
	* @returns {boolean} Returns true if the values are different, else false.
	*
	* @example expect.notEqual({ "a":1 }, { "a":false })
	*/
	notEqual(param_actual:="_Missing_Parameter_", param_expected:="_Missing_Parameter_", param_note:="") {
		if (A_IsCompiled) {
			return 0
		}
		if (param_note == "" && this.lastlabel == "") {
			param_note := "Expected to be different"
		}
		; prepare
		param_actual := this._print(param_actual)
		param_expected := this._print(param_expected)
		; create
		this.testTotal += 1
		if (param_actual != param_expected) {
			this.successTotal++
			return true
		} else {
			this._logTestFail(param_actual, param_expected, param_note)
			return false
		}
	}
	/**
	* checks if actual and expected inputs are the same or equal. The comparison is always case-sensitive.
	* @param {number|string|object} param_actual - The actual value computed.
	* @param {number|string|object} param_expected - The expected value.
	* @param {string} param_note - Additional notes for the test (Optional).
	*
	* @returns {boolean} Returns true if the values are equal, else false.
	*/
	test(param_actual:="_Missing_Parameter_", param_expected:="_Missing_Parameter_", param_note:="") {
		if (A_IsCompiled) {
			return 0
		}
		; prepare
		if (isObject(param_actual)) {
			param_actual := this._print(param_actual)
		}
		if (isObject(param_expected)) {
			param_expected := this._print(param_expected)
		}
		; create
		this.testTotal++
		if (param_actual == param_expected) {
			this._stdOut("ok " this.testTotal)
			this.successTotal++
			return true
		} else {
			this._logTestFail(param_actual, param_expected, param_note)
			return false
		}
	}
	/**
	* checks if `param_actual` value is true.
	* @param {number|string} param_actual - The actual value computed.
	* @param {string} param_note - Additional notes for the test (Optional).
	*
	* @returns {boolean} Returns true if the values are different, else false.
	*
	* @example expect.true((1 == 1))
	*/
	true(param_actual:="_Missing_Parameter_", param_note:="") {
		if (A_IsCompiled) {
			return 0
		}
		; create
		this.test(param_actual, true, param_note)
		return false
	}
	/**
	* checks if `param_actual` input is false.
	* @param {number|string|object} param_actual - The actual value computed.
	* @param {string} param_note - Additional notes for the test (Optional).
	*
	* @returns {boolean} returns true if the value is false, else false
	*
	* @example expect.false((99 < 3))
	*/
	false(param_actual:="_Missing_Parameter_", param_note:="") {
		if (A_IsCompiled) {
			return 0
		}
		; create
		if (param_actual == false) {
			this.test("false", "false", param_note)
			return true
		}
		if (param_actual == true){
			this.test("true", "false", param_note)
			return false
		}
		this.test(param_actual, "true", param_note)
		return false
	}
	/**
	* checks if `param_actual` is undefined (`""`).
	* @param {number|string} param_actual - The actual value computed.
	* @param {string} param_note - Additional notes for the test (Optional).
	*
	* @returns {boolean} returns true if the value is `""`, else false
	*
	* @example expect.undefined("")
	*/
	undefined(param_actual:="_Missing_Parameter_", param_note:="") {
		if (A_IsCompiled) {
			return 0
		}
		; create
		this.test(param_actual, "", param_note)
		return false
	}
	/**
	* appends the label to a group of following tests for logs and readability
	* @param {string} param_label - A human readable label prepend for the next test(s) in sequence
	*
	* @example expect.group("Object Tests")
	*/
	group(param_label) {
		if (A_IsCompiled) {
			return 0
		}
		this.groupVar := param_label
		this.labelVar := ""
		this.lastlabel := "_"
		this._stdOut("# " param_label)
		return
	}
	/**
	* labels the following tests for logs and readability
	* @param {string} param_label - A human readable label for the next test(s) in sequence
	* 
	* @example expect.label("myInterestingLabel")
	*/
	label(param_label) {
		if (A_IsCompiled) {
			return 0
		}
		this.labelVar := param_label
		return
	}
	_buildReport() {
		if (A_IsCompiled) {
			return 0
		}
		; create
		this.percentsuccess := floor( ( this.successTotal / this.testTotal ) * 100 )
		returntext := this.testTotal " tests completed with " this.percentsuccess "% success (" this.failTotal " failures)"
		if (this.failTotal = 1) {
			returntext := strReplace(returntext, "failures", "failure")
		}
		if (this.testTotal = 1) {
			returntext := strReplace(returntext, "tests", "test")
		}
		return returntext
	}
	_final() {
		if (A_IsCompiled) {
			return 0
		}
		; create
		this._stdOut("1.." this.testTotal)
		this._stdOut("# " this._buildReport())
		this.finalTrigger := true
		return true
	}
	_logTestFail(param_actual, param_expected, param_msg:="") {
		if (A_IsCompiled) {
			return 0
		}
		; create
		this.failTotal++
		if (param_msg != "") {
			this.labelVar := param_msg
		}
		if (this.labelVar != this.lastlabel) {
			this.lastlabel := this.labelVar
			if (this.groupVar) {
				this.log.push("")
				this.log.push("## " this.groupVar "")
			}
			this.log.push("- Test Number: " this.failTotal "  ")
			if (this.labelVar != "") {
				this.log.push(this.labelVar "  ")
			}
			this.log.push("Expected: " param_expected "  ")
			this.log.push("Actual: " param_actual "  ")
		}
		groupStr := ""
		if (this.groupVar != "") {
			groupStr := this.groupVar "; "
		}
		msg := "not ok " this.testTotal " - " groupStr this.labelVar "`n"
		msg .= "    ---`n"
		msg .= "    Expected: " param_expected "`n"
		msg .= "    Got: " param_actual "`n"
		msg .= "    ..."
		this._stdOut(msg)
	}
	; # 2 tests completed with 0`% success (2 failures)
	; - Test Number: 1  
	; expect true for myCoolFunc  
	; Expected: 1  
	; Actual: 0
	; ## This Group
	; - Test Number: 2 
	; expect true for myOtherFunc  
	; Expected: 1  
	; Actual: 0  
	_print(param_value) {
		if (isObject(param_value)) {
			for key, value in param_value {
				if key is not number
				{
					output .= """" . key . """:"
				} else {
					output .= key . ":"
				}
				if (isObject(value)) {
					output .= "[" . this._print(value) . "]"
				} else if value is not number
				{
					output .= """" . value . """"
				}
				else {
					output .= value
				}
				output .= ", "
			}
			return subStr(output, 2)
		}
		return param_value
	}
	_stdOut(output:="") {
		try {
			fileAppend, % output, *
		} catch error {
			return false
		}
		return true
	}
	/**
	* Writes the report to a file.
	* @param {string} param_filepath - The path of the file where the report will be written. If not provided, the default logResultPath will be used.
	* @throws {exception} If there is an error writing the report to the disk.
	*
	* @returns {string} The report that was written to the file.
	* 
	* @example expect.writeResultsToFile(".\myLogFile.tap")
	*/  
	writeResultsToFile(param_filepath:=".\results.test.log") {
		if (A_IsCompiled) {
			return 0
		}
		; prepare
		if (subStr(param_filepath, 1, 2) == ".\") {
			param_filepath := A_WorkingDir subStr(param_filepath, 2)
		}
		; create
		if (inStr(param_filepath, "*") == 0) {
			try {
				fileDelete, % param_filepath
			} catch {
				; do nothing
			}
		}
		msgReport := "# " this._buildReport() "`n`n"
		for key, value in this.log {
			msgReport .= value "`n"
		}
		fileAppend, % msgReport, % param_filepath
		if (errorlevel == 1) {
			throw exception("Failed to write report to disk")
		}
		return msgReport
	}
	/**
	* returns the full test results. This should be used with to integrate with Continuous Integration (CI) Systems
	* @param {}
	*
	* @returns {string} returns a string containing all the test results.
	*
	* @example expect.report()
	*/
	report() {
		if (A_IsCompiled) {
			return 0
		}
		; create
		if (!this.finalTrigger) {
			this._final()
		}
		return this._buildReport()
	}
	/**
	* Uses msgbox to display the results of all tests with details of any failures
	* @param {} 
	*
	* @returns {string} The generated full report message.
	*
	* @example expect.fullReport()
	*/
	fullReport() {
		if (A_IsCompiled) {
			return 0
		}
		; create
		if (!this.finalTrigger) {
			this._final()
		}
		msgReport := this._buildReport()
		if (this.failTotal > 0) {
			msgReport .= "`n==========================="
			loop % this.log.Count() {
				msgReport .= "`n" this.log[A_Index]
			}
		}
		; choose the msgbox icon
		if (this.failTotal > 0) {
			l_options := 48
		} else {
			l_options := 64
		}
		msgbox, % l_options, expect.ahk, % msgReport
		return msgReport
	}
;; end of expect.ahk
}