"""
In short:
	Template for other scripts.
"""

"""
#################### INIT START ####################
"""

""" Reset """
from sage.misc.reset import reset
reset()

""" Import and define """
from os import system
from myFunctions import double_print

variables_names = ''

def declare_variables():
	""" Declare variables """
	variables_names = ''
	# Add x, y, z, h, t, k
	variables_names += 'x, y, z, h, t, k'
	# Add x0, x1, ... if needed
	if vectors_length > 3:
		for i in range(0, vectors_length):
			variables_names += (', x' + str(i))
	# Add h, t, ... if present
	if new_variables_name != '':
		variables_names += ', ' + new_variables_name

	double_print("Variables", variables_names)
	# Declare and inject variables
	R = PolynomialRing(QQ, variables_names)
	R.inject_variables()

""" Clear the terminal and set the debug print level """
fine_debug = false
system('clear')

"""
#################### INIT STOP ####################
"""

"""
#################### USER START ####################
"""

""" Initialize variables """
# x, y, z, h, t, k are declared for default
new_variables_name = ''
vectors_length = 3

declare_variables()

""" Basis vectors as matrix rows """
Content = [
	[1, 0, 0],
	[0, 1, 0],
	[0, 0, 1]
]

"""
#################### USER END ####################
"""

"""
#################### COMPUTATION START ####################
"""

"""
#################### COMPUTATION END ####################
"""
