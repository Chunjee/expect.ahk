_print(param_value) {
	if (isObject(param_value)) {
		for key, value in param_value {
			if key is not number
			{
				output .= """" . key . """:"
			} else {
				output .= key . ":"
			}
			if (isObject(value)) {
				output .= "[" . this._print(value) . "]"
			} else if value is not number
			{
				output .= """" . value . """"
			}
			else {
				output .= value
			}
			output .= ", "
		}
		return subStr(output, 2)
	}
	return param_value
}
