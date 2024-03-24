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
			this.log.push("== " this.groupVar " - " this.labelVar " ==")
		} else {
			this.log.push("== " this.labelVar " ==")
		}
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
	this.log.push(msg)
}
