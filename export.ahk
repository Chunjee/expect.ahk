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

		this.logResultPath := A_ScriptDir "\result.tests.log"
	}


	/**
	* checks if actual and expected are the same or equal. The comparison is case-insensitive when ahk is `StringCaseSense, Off` (default ahk behavior) and case sensitive when `inStringCaseSense, On`
	* @param {number|string|object} param_actual - The actual value computed.
	* @param {number|string|object} param_expected - The expected value.
	* @param {string} param_note - Additional notes for the test (optional).
	* @returns {boolean} Returns true if the values are different, else false.
	*/
	equal(param_actual:="_Missing_Parameter_", param_expected:="_Missing_Parameter_", param_note:="") {
		if (A_IsCompiled) {
			return 0
		}

		; create
		return this.test(param_actual, param_expected, param_note)
	}


	/**
	* checks if actual value is false.
	* @param {number|string|object} param_actual - The actual value computed.
	* @param {string} param_note - Additional notes for the test (optional).
	* @returns {boolean} returns true if the value is false, else false
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
	* checks if actual and expected are NOT the same or equal. The comparison is case-insensitive when ahk is `StringCaseSense, Off` (default ahk behavior) and case sensitive when `inStringCaseSense, On`
	* @param {number|string|object} param_actual - The actual value computed.
	* @param {number|string|object} param_expected - The expected value.
	* @param {string} param_note - Additional notes for the test (optional).
	* @returns {boolean} Returns true if the values are different, else false.
	*/
	notEqual(param_actual:="_Missing_Parameter_", param_expected:="_Missing_Parameter_", param_note:="") {
		if (A_IsCompiled) {
			return 0
		}
		if (param_note == "") {
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
	* checks if actual and expected are the same or equal. The comparison is case-insensitive when ahk is `StringCaseSense, Off` (default ahk behavior) and case sensitive when `inStringCaseSense, On`
	* @param {number|string|object} param_actual - The actual value computed.
	* @param {number|string|object} param_expected - The expected value.
	* @param {string} param_note - Additional notes for the test (optional).
	* @returns {boolean} Returns true if the values are equal, else false.
	*/
	test(param_actual:="_Missing_Parameter_", param_expected:="_Missing_Parameter_", param_note:="") {
		if (A_IsCompiled) {
			return 0
		}

		; prepare
		if (IsObject(param_actual)) {
			param_actual := this._print(param_actual)
		}
		if (IsObject(param_expected)) {
			param_expected := this._print(param_expected)
		}

		; create
		this.testTotal++
		if (param_actual != param_expected) { ; != follows StringCaseSense
			this._logTestFail(param_actual, param_expected, param_note)
			return false
		} else {
			this._stdOut("ok " this.testTotal)
			this.successTotal++
			return true
		}
	}



	/**
	* checks if actual value is true.
	* @param {number|string} param_actual - The actual value computed.
	* @param {string} param_note - Additional notes for the test (optional).
	* @returns {boolean} Returns true if the values are different, else false.
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
	* checks if actual is undefined (`""`).
	* @param {number|string} param_actual - The actual value computed.
	* @param {string} param_note - Additional notes for the test (optional).
	* @returns {boolean} returns true if the value is `""`, else false
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
	*/
	group(param_label) {
		if (A_IsCompiled) {
			return 0
		}

		this.groupVar := param_label
		this.labelVar := ""
		this.lastlabel := "_"
		this._stdOut("# " this.groupVar)
		return
	}



	/**
	* labels the following tests for logs and readability
	* @param {string} param_label - A human readable label for the next test(s) in sequence
	* 
	* @example label("myInterestingLabel")
	*/
	label(param) {
		if (A_IsCompiled) {
			return 0
		}

		this.labelVar := param
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
			returntext := StrReplace(returntext, "failures", "failure")
		}
		if (this.testTotal = 1) {
			returntext := StrReplace(returntext, "tests", "test")
		}
		return returntext
	}



	_final() {
		if (A_IsCompiled) {
			return 0
		}

		; create
		this._stdOut("# " this._buildReport())
		this._stdOut("1.." this.testTotal)
		this.finalTrigger := true
		return true
	}



	_logTestFail(param_actual, param_expected, param_msg:="") {
		if (A_IsCompiled) {
			return 0
		}

		; create
		this.failTotal++
		if (this.labelVar != this.lastlabel) {
			this.lastlabel := this.labelVar
			if (this.groupVar != "") {
				this.log.push("`n== " this.groupVar " - " this.labelVar " ==`n")
			} else {
				this.log.push("`n== " this.labelVar " ==`n")
			}
		}
		this._stdOut("not ok " this.testTotal " - " this.labelVar)
		this.log.push("    Test Number: " this.testTotal "`n")
		this.log.push("    Expected: " param_expected "`n")
		this.log.push("    Actual: " param_actual "`n")
		if (param_msg != "") {
			this.log.push(param_msg "`n")
		}
	}



	_print(param_value) {
		if (isObject(param_value)) {
			for key, value in param_value {
				if key is not Number
				{
					output .= """" . key . """:"
				} else {
					output .= key . ":"
				}
				if (IsObject(value)) {
					output .= "[" . this._print(value) . "]"
				} else if value is not Number
				{
					output .= """" . value . """"
				}
				else {
					output .= value
				}
				output .= ", "
			}
			output := subStr(output, 1, strLen(output) - 2)
			return output
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
	* Writes the results to a file at the specified filepath or default log path.
	* @param {string} [param_filepath=""] - The filepath where the results will be written. Defaults to the default log path if not provided.
	* @param {boolean} [openFile=false] - A flag indicating whether to open the file after writing the results. Defaults to false.
	* @returns {boolean} Returns true if the results are successfully written to the file, else false if an error occured
	*/
	writeResultsToFile(param_filepath:="", openFile:=false) {
		if (A_IsCompiled) {
			return 0
		}

		; prepare
		if (param_filepath != "") {
			logpath := param_filepath
		} else {
			logpath := this.logResultPath
		}

		; create
		try {
			fileDelete, % logpath
		} catch {
			; do nothing
		}
		msgReport := this._buildReport() "`n"
		for key, value in this.log {
			msgReport .= msgReport "`n"
		}
		fileAppend, % msgReport, % logpath

		if (openFile) {
			run, % logpath
		}
		if (errorlevel == 0) {
			return true
		}
		return false
	}



	/**
	* Uses msgbox to display the results of all tests with details of any failures
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
			msgReport .= "`n=================================`n"
		}
		loop % this.log.Count() {
			msgReport .= this.log[A_Index]
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



	/**
	* writes tests out in TAP format
	* @returns {string} The generated report message.
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
		msgReport := this._buildReport()
		if (this.failTotal > 0) {
			msgReport .= "`n=================================`n"
		}
		loop % this.log.Count() {
			this._stdOut(this.log[A_Index])
		}
		return msgReport
	}


	;; end of expect.ahk
}
