"""
	Template.
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

parameters_are_variables = False
rref_instead_of_echelon_form = False
fine_debug = False

def declare_variables():
	""" Declare variables """
	variables_names = ''
	# Add x, y, z
	variables_names += 'x, y, z'
	# Add x0, x1, ... if needed
	if vectors_length > 3:
		for i in range(0, vectors_length):
			variables_names += (', x' + str(i))

	parameters_name = ""
	# Add h, t, k
	parameters_name += 'h, t, k'
	# Add new_parameters_name if present
	if new_parameters_name != '':
		parameters_name += ', ' + new_parameters_name

	if parameters_are_variables:
		variables_names += ', ' + parameters_name

	double_print("Variables", variables_names)
	# Declare and inject variables
	R = PolynomialRing(QQ, variables_names)
	R.inject_variables()
	
	if not parameters_are_variables:
		parameters = var(parameters_name)

	return R

""" Clear the terminal """
system('clear')

"""
#################### INIT STOP ####################
"""

"""
#################### USER START ####################
"""

""" Initialize variables """
# x, y, z, h, t, k are declared for default
new_parameters_name = ''
vectors_length = 4

R = declare_variables()

""" Content """
Content = [
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
