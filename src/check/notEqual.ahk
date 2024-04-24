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
