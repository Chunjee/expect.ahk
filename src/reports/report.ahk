/**
* returns the full test results. This should be used with to integrate with Continuous Integration (CI) Systems
* @param {}
*
* @returns {string} returns a string containing all the test results.
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
	return this._buildReport()
}
