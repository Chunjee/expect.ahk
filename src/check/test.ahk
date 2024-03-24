/**
* checks if actual and expected inputs are the same or equal. The comparison is always case-sensitive.
* @param {number|string|object} param_actual - The actual value computed.
* @param {number|string|object} param_expected - The expected value.
* @param {string} param_note - Additional notes for the test (Optional).
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
