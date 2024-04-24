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
