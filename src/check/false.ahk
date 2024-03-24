/**
* checks if actual input is false.
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
