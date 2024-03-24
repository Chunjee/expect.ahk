/**
* labels the following tests for logs and readability
* @param {string} param_label - A human readable label for the next test(s) in sequence
* 
* @example expect.label("myInterestingLabel")
*/
label(param_label) {
	if (A_IsCompiled) {
		return 0
	}

	this.labelVar := param_label
	return
}
