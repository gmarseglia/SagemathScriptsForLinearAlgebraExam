"""
	declare_variables with var and polynomial ring.
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

variables_are_in_polynomial_ring = False
parameters_are_in_polynomial_ring = False

rref_instead_of_echelon_form = False
fine_debug = False

def declare_variables():
	""" Add all variables names """
	variables_names = ''
	# Add x, y, z
	variables_names += 'x, y, z'
	# Add x0, x1, ... if needed
	if vectors_length > 3:
		for i in range(0, vectors_length):
			variables_names += (', x' + str(i))

	""" Add all parameters names """
	parameters_names = ""
	# Add h, t, k
	parameters_names += 'h, t, k'
	# Add new_parameters_names if present
	if new_parameters_names != '':
		parameters_names += ', ' + new_parameters_names

	""" Combine according to boolean in symbolic names and
		polynomial ring names """
	symbolic_names = ""
	polynomial_ring_names = ""

	if variables_are_in_polynomial_ring:
		polynomial_ring_names += variables_names
	else:
		symbolic_names += variables_names

	if parameters_are_in_polynomial_ring:
		if polynomial_ring_names != "" : polynomial_ring_names += ', '
		polynomial_ring_names += parameters_names
	else:
		if symbolic_names != "" : symbolic_names += ', '
		symbolic_names += parameters_names

	""" Declare variables and parameters according to boolean """
	# var() style
	print("\nDeclaring variables:")
	if symbolic_names != "":
		print('\tAs var():\t\t{}'.format(symbolic_names))
		var(symbolic_names)

	# PolynomialRing and inject style
	if polynomial_ring_names != "":
		print('\tWith PolynomialRing:\t{}'.format(polynomial_ring_names))
		R = PolynomialRing(QQ, polynomial_ring_names)
		R.inject_variables(verbose=False)
		return R

	return False

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
new_parameters_names = ''
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
