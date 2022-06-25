"""
    Risolve il sistema lineare omogeneo.
"""

"""
#################### INIT START ####################
"""

""" Reset """
reset()
os.system('clear')

""" Import and define """
load("myModule.sage")

""" DON'T MODIFY """
use_gauss_reduction = False
gauss_rescale_leading_entry = False
variables_are_in_polynomial_ring = True
parameters_are_in_polynomial_ring = True


vectors_length = 3
use_rref_instead_of_echelon_form = True

fine_debug = False


""" Initialize variables """
# x, y, z, h, t, k are declared for default
R, Xn_list = declare_variables(vectors_length = vectors_length, new_parameters_names = '',
    variables_are_in_polynomial_ring = False, parameters_are_in_polynomial_ring = False)

"""
#################### INIT STOP ####################
"""

"""
#################### USER START ####################
"""


""" Basis vectors as matrix rows """
Content = [
    [1,-1,-1],
    [1,-3,1]
]

""" Create the matrix """
M = matrix(Content)
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
    print(Xn.dot_product(M.row(i)))

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

""" Remove 0 rows """
# All 0 rows are deleted to ensure the basis vector are correct in size
MEchelon = MEchelon.submatrix(0, 0, MEchelon.rank(), MEchelon.ncols())

""" Compute the pivots """
pivots_columns = MEchelon.pivots()
pivots_rows = MEchelon.pivot_rows()
pivots = []
for i in range(0, len(pivots_columns)):
    pivots.append((pivots_columns[i], pivots_rows[i]))
double_print("Pivots", pivots)

""" Change the sign of the columns that are not pivots """
# This is part of the algorithm
M_SIGN_CHANGED = copy(MEchelon)
not_pivots_columns = []
for i in range(0, M_SIGN_CHANGED.ncols()):
    if not i in pivots_columns:
        M_SIGN_CHANGED.rescale_col(i, -1)
        not_pivots_columns.append(i)

"""  Compute the final matrix that will have the basis vector as its columns """
# This part is a bit confusing but in short M_FINAL is a matrix with basis vectors as its columns
M_ONLY_NOT_PIVOTS   = M_SIGN_CHANGED.matrix_from_columns(not_pivots_columns)
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
#################### USER END ####################
"""
