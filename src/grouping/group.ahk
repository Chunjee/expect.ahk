/**
* appends the label to a group of following tests for logs and readability
* @param {string} param_label - A human readable label prepend for the next test(s) in sequence
*
* @example expect.group("Object Tests")
*/
group(param_label) {
	if (A_IsCompiled) {
		return 0
	}

	this.groupVar := param_label
	this.labelVar := ""
	this.lastlabel := "_"
	this._stdOut("# " param_label)
	return
}
