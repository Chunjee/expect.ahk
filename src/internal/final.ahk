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
