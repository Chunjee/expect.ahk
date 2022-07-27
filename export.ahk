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
		if (A_StringCaseSense = "Off") {
			toggleCaseSenseOff := true
		} else {
			toggleCaseSenseOff := false
		}
		StringCaseSense, On
		if (param_actual == param_expected) {
			this._stdOut("ok " this.testTotal)
			this.successTotal++
			if (toggleCaseSenseOff) {
				StringCaseSense, Off
			}
			return true
		} else {
			this._logTestFail(param_actual, param_expected)
			if (toggleCaseSenseOff) {
				StringCaseSense, Off
			}
			return false
		}
	}

	_logTestFail(param_actual, param_expected, param_msg:="") {
		if (A_IsCompiled) {
			return 0
		}

		; create
		this.failTotal++
		if (this.labelVar != this.lastlabel) {
			this.lastlabel := this.labelVar
			if (this.groupVar) {
				this.log.push("`n== " this.groupVar " - " this.labelVar " ==`n")
			} else {
				this.log.push("`n== " this.labelVar " ==`n")
			}
		}
		this._stdOut("not ok " this.testTotal " - " this.labelVar)
		this.log.push("Test Number: " this.testTotal "`n")
		this.log.push("Expected: " param_expected "`n")
		this.log.push("Actual: " param_actual "`n")
		if (param_msg != "") {
			this.log.push(param_msg "`n")
		}
		this.log.push("`n")
	}


	true(param_actual:="_Missing_Parameter_", param_note:="") {
		if (A_IsCompiled) {
			return 0
		}

		; create
		this.test(param_actual, true, param_note)
		return false
	}


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


	equal(param_actual:="_Missing_Parameter_", param_expected:="_Missing_Parameter_", param_note:="") {
		if (A_IsCompiled) {
			return 0
		}

		; create
		return this.test(param_actual, param_expected, param_note)
	}


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

	label(param) {
		if (A_IsCompiled) {
			return 0
		}

		this.labelVar := param
		return
	}

	group(param) {
		if (A_IsCompiled) {
			return 0
		}

		this.groupVar := param
		this.labelVar := ""
		this.lastlabel := "_"
		this._stdOut("# " param)
		return
	}

	final() {
		if (A_IsCompiled) {
			return 0
		}
		this._stdOut("# " this._buildReport())
		this._stdOut("1.." this.testTotal)
		return true
	}


	fullReport() {
		if (A_IsCompiled) {
			return 0
		}

		msgreport := this._buildReport()
		if (this.failTotal > 0) {
			msgreport .= "`n=================================`n"
		}
		loop % this.log.Count() {
			msgreport .= this.log[A_Index]
		}

		; choose the msgbox icon
		if (this.failTotal > 0) {
			l_options := 48
		} else {
			l_options := 64
		}
		; this._stdOut(msgreport)
		msgbox, % l_options, expect.ahk, % msgreport
		return msgreport
	}

	writeTAP(param_filepath:="", openFile:=false) {

	}

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
			FileDelete, % logpath
		} catch {
			; do nothing
		}

		msgreport := this._buildReport()
		FileAppend, % msgreport "`n`n", % logpath
		for key, value in this.log {
			FileAppend, % value, % logpath
		}
		if (openFile) {
			Run, % logpath
		}
		return true
	}

	; Internal functions
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


	_print(param_value) {
		if (IsObject(param_value)) {
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
			StringTrimRight, output, output, 2
			return output
		}
		return param_value
	}

	_stdOut(output:="") {
		try {
			DllCall("AttachConsole", "int", -1)
			FileAppend, % "`n" output, CONOUT$
			DllCall("FreeConsole")
		} catch error {
			return false
		}
		return true
	}
}
