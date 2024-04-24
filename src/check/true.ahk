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
