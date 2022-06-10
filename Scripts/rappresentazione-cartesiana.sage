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
	[1, 0, 1],
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
double_print("Xn", Xn)

""" Create matrix that will define the constraints """
M_stacked_transposed = M.stack(matrix([Xn])).transpose()
double_print("M_stacked_transposed", M_stacked_transposed)

""" Reduce the matrix to the echelon form """
M_final = M_stacked_transposed.echelon_form()
double_print('M_final', M_final)

"""
#################### COMPUTATION END ####################
"""
