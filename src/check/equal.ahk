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
