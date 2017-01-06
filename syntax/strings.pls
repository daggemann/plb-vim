	move "This is a string" to Not a string
	move This is not a string to "A string"
	move "This is also a #"string#"" to Not a string
	move "This is a string with ""quotes""" to not a string
	TODO	cmove "#" to string // This should only make "#" a string
