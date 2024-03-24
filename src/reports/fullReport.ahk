/**
* Uses msgbox to display the results of all tests with details of any failures
* @param {} 
*
* @returns {string} The generated full report message.
*
* @example expect.fullReport()
*/
fullReport() {
	if (A_IsCompiled) {
		return 0
	}

	; create
	if (!this.finalTrigger) {
		this._final()
	}
	msgReport := this._buildReport()
	if (this.failTotal > 0) {
		msgReport .= "================================="
		loop % this.log.Count() {
			msgReport .= "`n" this.log[A_Index]
		}
	}

	; choose the msgbox icon
	if (this.failTotal > 0) {
		l_options := 48
	} else {
		l_options := 64
	}
	msgbox, % l_options, expect.ahk, % msgReport
	return msgReport
}
