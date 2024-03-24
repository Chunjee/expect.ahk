_buildReport() {
	if (A_IsCompiled) {
		return 0
	}

	; create
	this.percentsuccess := floor( ( this.successTotal / this.testTotal ) * 100 )
	returntext := this.testTotal " tests completed with " this.percentsuccess "% success (" this.failTotal " failures)"
	if (this.failTotal = 1) {
		returntext := strReplace(returntext, "failures", "failure")
	}
	if (this.testTotal = 1) {
		returntext := strReplace(returntext, "tests", "test")
	}
	return returntext
}
