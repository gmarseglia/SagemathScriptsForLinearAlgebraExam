"""
    Risolve i sistemi lineari non omogenei con parametro k.
"""

"""
#################### INIT START ####################
"""

""" Reset """
reset()
os.system('clear')

""" Import and define """
load("myModule.sage")

vectors_length = 4
new_parameters_names = ''

use_gauss_reduction = False
gauss_rescale_leading_entry = True

variables_are_in_polynomial_ring = False
parameters_are_in_polynomial_ring = False

use_rref_instead_of_echelon_form = False

fine_debug = True

""" Initialize variables """
# x, y, z, h, t, k are declared for default
R, Xn_list = declare_variables(vectors_length, new_parameters_names,
    variables_are_in_polynomial_ring, parameters_are_in_polynomial_ring)

"""
#################### INIT STOP ####################
"""

"""
#################### CONFIG START ####################
"""



"""
#################### CONFIG STOP ####################
"""

"""
#################### USER START ####################
"""

""" Assumptions and assignements """
if not parameters_are_in_polynomial_ring:
    assume(k, 'real')
# k = 0

A = Matrix([
    [2, k+1, 1, 1],
    [2, 2*k+2, k+2, 1],
    [2, k+1, k-1, 1]
])

B = Matrix(3, [4, k+6, k+2])

double_print("k", k)

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
    Xn = vector([x, y, z])
else:
    if not variables_are_in_polynomial_ring:
        Xn = vector(Xn_list[3:3+vectors_length])
    else:
        Xn = vector(R.gens()[3:3+vectors_length])
double_print("Xn", Xn)

""" Print the constraints """
print("\nConstraints:")
for i in range(0, M.nrows()):
    f = Xn.dot_product(A.row(i))
    print(f,"=",B.row(i)[0])

""" Reduce the matrix to the echelon form """
message = "MEchelon "
if use_gauss_reduction:
    message += "(using gauss_method)"
    MEchelon = gauss_method(M, gauss_rescale_leading_entry, fine_debug)
else:
    if use_rref_instead_of_echelon_form:
        message += "(using .rref())"
        MEchelon = M.rref()
    else:
        message += "(using .echelonize())"
        MEchelon = copy(M)
        MEchelon.echelonize()

double_print(message, MEchelon)

if MEchelon.submatrix(0, 0, MEchelon.nrows(), MEchelon.nrows()).is_symmetric and not variables_are_in_polynomial_ring and not use_gauss_reduction:
    """ Compute the pivots """
    pivots_columns = MEchelon.pivots()
    pivots_rows = MEchelon.pivot_rows()
    pivots = []
    for i in range(0, len(pivots_columns)):
        pivots.append( ((pivots_rows[i], pivots_columns[i]), MEchelon[pivots_rows[i]][pivots_columns[i]]) )
    double_print("Pivots", pivots)

    print("\nConditions:")
    for i in range(0, len(pivots)):
        f = (Xn[i] == MEchelon[i][MEchelon.ncols()-1])
        print(str(solve(f, Xn[i])).replace("[","").replace("]","").replace("\n","").replace(",",", "))

"""
#################### COMPUTATION END ####################
"""
