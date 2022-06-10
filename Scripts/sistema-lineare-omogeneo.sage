"""
	Risolve sistemi lineari omogenei,
	e permette di calcolare una base data la rappresentazione cartesiana.
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
rref_instead_of_echelon_form = True
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

""" Basis vectors as matrix rows """
Content = [
	[1, 1, 1, h],
	[1, 2, -2, -1]
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

""" Create variables vector """
if vectors_length <= 3:
	Xn_list = [x, y, z]
else:
	Xn_list = []
	for i in range(3, 3 + vectors_length):
		Xn_list.append( R.gen(i) )
Xn = vector(Xn_list)
double_print("Xn", Xn)

""" Print the constraints """
print("\nConstraints:")
for i in range(0, M.nrows()):
	print(Xn.dot_product(M.row(i)))

""" Echelonize the matrixm and print """
# .rref() is preferred because use fractions
if rref_instead_of_echelon_form:
	M_ECHELON = M.rref()
	print("\nM_ECHELON (using rref):")
else:
	M_ECHELON = M.echelon_form()
	print("\nM_ECHELON (using echelon_form):")
print(M_ECHELON)

""" Remove 0 rows """
# All 0 rows are deleted to ensure the basis vector are correct in size
M_ECHELON = M_ECHELON.submatrix(0, 0, M_ECHELON.rank(), M_ECHELON.ncols())

""" Compute the pivots """
pivots_columns = M_ECHELON.pivots()
pivots_rows = M_ECHELON.pivot_rows()
pivots = []
for i in range(0, len(pivots_columns)):
	pivots.append((pivots_columns[i], pivots_rows[i]))
double_print("Pivots", pivots)

""" Change the sign of the columns that are not pivots """
# This is part of the algorithm
M_SIGN_CHANGED = copy(M_ECHELON)
not_pivots_columns = []
for i in range(0, M_SIGN_CHANGED.ncols()):
	if not i in pivots_columns:
		M_SIGN_CHANGED.rescale_col(i, -1)
		not_pivots_columns.append(i)

"""  Compute the final matrix that will have the basis vector as its columns """
# This part is a bit confusing but in short M_FINAL is a matrix with basis vectors as its columns
M_ONLY_NOT_PIVOTS	= M_SIGN_CHANGED.matrix_from_columns(not_pivots_columns)
MM_SPACE = MatrixSpace(M_ONLY_NOT_PIVOTS.base_ring(), M_ONLY_NOT_PIVOTS.ncols(), M_ONLY_NOT_PIVOTS.ncols())
M_FINAL = M_ONLY_NOT_PIVOTS.stack(MM_SPACE.identity_matrix())

""" Fine print """
if fine_debug:
	double_print("M_SIGN_CHANGED", M_SIGN_CHANGED)
	double_print("M_ONLY_NOT_PIVOTS", M_ONLY_NOT_PIVOTS)
	double_print("M_FINAL", M_FINAL)

""" Print the basis """
print("\nBasis:")
for i in range(0, M_FINAL.ncols()):
	print(M_FINAL.column(i))

"""
#################### COMPUTATION END ####################
"""
