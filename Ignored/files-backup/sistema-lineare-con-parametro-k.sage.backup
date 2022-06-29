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

parameters_are_variables = True
use_gauss_reduction = True
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

# Naive Gaussian reduction
def gauss_method(M,rescale_leading_entry=False):
    """Describe the reduction to echelon form of the given matrix of rationals.

    M  matrix of rationals   e.g., M = matrix(QQ, [[..], [..], ..])
    rescale_leading_entry=False  boolean  make the leading entries to 1's

    Returns: None.  Side effect: M is reduced.  Note: this is echelon form, 
    not reduced echelon form; this routine does not end the same way as does 
    M.echelon_form().

    """
    num_rows=M.nrows()
    num_cols=M.ncols()
    if fine_debug:
    	print(M)    

    col = 0   # all cols before this are already done
    for row in range(0,num_rows): 
        # ?Need to swap in a nonzero entry from below
        while (col < num_cols
               and M[row][col] == 0): 
            for i in M.nonzero_positions_in_column(col):
                if i > row:
                    M.swap_rows(row,i)
                    if fine_debug:
	                    print(" swap row",row+1,"with row",i+1)
	                    print(M)
                    break     
            else:
                col += 1

        if col >= num_cols:
            break

        # Now guaranteed M[row][col] != 0
        if (rescale_leading_entry
           and M[row][col] != 1):
            M.rescale_row(row,1/M[row][col])
            if fine_debug:
	            print(" take",1/M[row][col],"times row",row+1)
	            print(M)
        change_flag=False
        for changed_row in range(row+1,num_rows):
            if M[changed_row][col] != 0:
                change_flag=True
                factor=-1*M[changed_row][col]/M[row][col]
                M.add_multiple_of_row(changed_row,row,factor)
                if fine_debug:
                	print(" take",factor,"times row",row+1,"plus row",changed_row+1) 
        if change_flag and fine_debug:
            	print(M)
        col +=1

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

k = 0

A = Matrix([
	[k, 1, 1],
	[k, k+2, 3],
	[k, 1, k]
])

B = Matrix(3, [(k^2)+3, k^2+k+8, k^2+2*k+1])

double_print("k", k)

# k has been assigned a value
if k in QQ:
	use_gauss_reduction = False

"""
#################### USER END ####################
"""

"""
#################### COMPUTATION START ####################
"""

""" Create the matrix """
M = A.augment(B, true)
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
	f = Xn.dot_product(A.row(i))
	print(f,"=",B.row(i)[0])

""" Echelonize the matrixm and print """
# .rref() is preferred because use fractions
M_ECHELON = copy(M)
if use_gauss_reduction:
	gauss_method(M_ECHELON)
	double_print("M_ECHELON (using gauss_method)", M_ECHELON)
else:
	if rref_instead_of_echelon_form:
		M_ECHELON = M.rref()
		double_print("M_ECHELON (using rref)", M_ECHELON)
	else:
		M_ECHELON = M_ECHELON.echelon_form()
		double_print("M_ECHELON (using echelon_form)", M_ECHELON)

""" Compute the pivots """
pivots_columns = M_ECHELON.pivots()
pivots_rows = M_ECHELON.pivot_rows()
pivots = []
for i in range(0, len(pivots_columns)):
	pivots.append((pivots_rows[i], pivots_columns[i]))
double_print("Pivots", pivots)

"""
#################### COMPUTATION END ####################
"""
