/**
* Writes the report to a file.
* @param {string} param_filepath - The path of the file where the report will be written. If not provided, the default logResultPath will be used.
* @throws {exception} If there is an error writing the report to the disk.
*
* @returns {string} The report that was written to the file.
* 
* @example expect.writeResultsToFile(".\myLogFile.tap")
*/  
writeResultsToFile(param_filepath:=".\results.test.log") {
	if (A_IsCompiled) {
		return 0
	}
	; prepare
	if (subStr(param_filepath, 1, 2) == ".\") {
		param_filepath := A_WorkingDir subStr(param_filepath, 2)
	}

	; create
	if (inStr(param_filepath, "*") == 0) {
		try {
			fileDelete, % param_filepath
		} catch {
			; do nothing
		}
	}
	msgReport := "# " this._buildReport() "`n`n"
	for key, value in this.log {
		msgReport .= value "`n"
	}
	fileAppend, % msgReport, % param_filepath
	if (errorlevel == 1) {
		throw exception("Failed to write report to disk")
	}
	return msgReport
}
