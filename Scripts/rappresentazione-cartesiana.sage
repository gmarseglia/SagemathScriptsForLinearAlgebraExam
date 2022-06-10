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

parameters_are_variables = True
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
vectors_length = 3

R = declare_variables()

""" Basis vectors as matrix rows """
Content = [
	[1, 0, k],
	[0, 0, 1]
]

"""
#################### USER END ####################
"""

"""
#################### COMPUTATION START ####################
"""

""" Create the matrix """
# M = matrix(RDF, Content)
M = matrix(Content)

""" Create variables vector """
if vectors_length <= 3:
	Xn = [x, y, z]
else:
	Xn = []
	for i in range(3, 3 + vectors_length):
		Xn.append( R.gen(i) )

double_print("M", M)
double_print("rank(M)", M.rank())
double_print("Xn", Xn)

""" Create matrix that will define the constraints """
M_stacked_transposed = M.stack(matrix([Xn])).transpose()
double_print("M_stacked_transposed", M_stacked_transposed)

""" Reduce the matrix to the echelon form """
if rref_instead_of_echelon_form:
	M_final = M_stacked_transposed.rref()
	print("\nM_final (using rref):")
else:
	M_final = M_stacked_transposed.echelon_form()
	print("\nM_final (using echelon_form):")
print(M_final)

"""
#################### COMPUTATION END ####################
"""
