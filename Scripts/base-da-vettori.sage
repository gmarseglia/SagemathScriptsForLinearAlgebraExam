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

""" Matrix with vectors as rows """
Content = [
	[1, 1, 1, 1],
	[0, 1, 1, 1],
	[1, 2, 2, 2]
]


"""
#################### USER END ####################
"""

"""
#################### COMPUTATION START ####################
"""

""" Create the matrix """
M = matrix(Content)
double_print("M", M)

""" Print vectors """
print("\nRows:")
for row in M.rows():
	print(row)

""" Print echelon_form and rref """
M_echelon = M.echelon_form()
M_rref = M.rref()

double_print("M_echelon", M_echelon)
double_print("M_rref", M_rref)

""" Print basis """
if rref_instead_of_echelon_form:
	print("\nBasis (using rref):")
	M_target = M_rref
else:
	print("\nBasis (using echelon_form):")
	M_target = M_echelon

for row in M_target.rows():
	if row != 0 :
		print(row)

"""
#################### COMPUTATION END ####################
"""
