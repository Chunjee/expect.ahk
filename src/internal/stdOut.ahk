_stdOut(output:="") {
	try {
		fileAppend, % output, *
	} catch error {
		return false
	}
	return true
}
