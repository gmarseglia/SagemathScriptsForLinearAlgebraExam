"""
In short:
	Template for other scripts.
"""

"""
Reset
"""
from sage.misc.reset import reset
reset()
from os import system
from myFunctions import double_print, declare_xyz

def declare_variables():
	"""
	Declare variables
	"""
	variables_names = ''
	variables_names += 'x, y, z'
	if vectors_length > 3:
		for i in range(0, vectors_length):
			variables_names += (', x' + str(i))
	if new_variables_name != '':
		variables_names += ', ' + new_variables_name

	double_print("Variables", variables_names)
	R = PolynomialRing(QQ, variables_names)
	R.inject_variables()

"""
	USER PART
"""

"""
Fill Content with vectors as rows
"""

new_variables_name = 'h, t'
vectors_length = 3

declare_variables()

Content = [
	[t, 0, 1 + h],
	[1, h, 1]
]

"""
	AUTOMATION PART
"""

"""
Clear the terminal and set the debug print level
"""
fine_debug = false
system('clear')


"""
Create the matrix
"""
# M = matrix(RDF, Content)
M = matrix(Content)

"""
Create variable vector
"""
if vectors_length <= 3:
	Xn = [x, y, z]
else:
	Xn = []
	for i in range(3, 3 + vectors_length):
		Xn.append( R.gen(i) )

double_print("M", M)
double_print("Xn", Xn)

M_stacked_transposed = M.stack(matrix([Xn])).transpose()
double_print("M_stacked_transposed", M_stacked_transposed)

M_final = M_stacked_transposed.echelon_form()
double_print('M_final', M_final)