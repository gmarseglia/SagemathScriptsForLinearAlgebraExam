"""
    Risolve il sistema lineare omogeneo.
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

    Xn_list = []
    if symbolic_names != "":
        print('\tAs var():\t\t{}'.format(symbolic_names))
        Xn_list = var(symbolic_names)

    # PolynomialRing and inject style
    R = false
    if polynomial_ring_names != "":
        print('\tWith PolynomialRing:\t{}'.format(polynomial_ring_names))
        R = PolynomialRing(QQ, polynomial_ring_names)
        R.inject_variables(verbose=False)

    return R, Xn_list

# Naive Gaussian reduction
def gauss_method(M):
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
        if gauss_rescale_leading_entry:
            print("\nInitiating Gauss Reduction (with rescale leading entry)")
        else:
            print("\nInitiating Gauss Reduction")
        double_print("Starting matrix", M)  

    col = 0   # all cols before this are already done
    for row in range(0,num_rows): 
        # ?Need to swap in a nonzero entry from below
        while (col < num_cols and M[row][col] == 0): 
            for i in M.nonzero_positions_in_column(col):
                if i > row:
                    if fine_debug: print(" Swap row",row+1,"with row",i+1)
                    M = M.with_swapped_rows(row,i)
                    if fine_debug: print(M)
                    break     
                else:
                    col += 1

        if col >= num_cols:
            break

        # Now guaranteed M[row][col] != 0
        q=1/M[row][col]
        try:
            q_is_real = q.is_real()
        except:
            q_is_real = false
        test = (not q == 1) and (q in QQ or q_is_real)
        # print('q: {}, test: {}'.format(q, test))
        if (gauss_rescale_leading_entry and test):
            if fine_debug: print(" Row",row+1,"times", q)
            M = M.with_rescaled_row(row, q)
            if fine_debug: print(M)

        for changed_row in range(row+1,num_rows):
            if not M[changed_row][col] == 0:
                factor=-1*M[changed_row][col]/M[row][col]
                if fine_debug: print(" Row",changed_row+1,"plus", factor, "times row", row+1)
                M = M.with_added_multiple_of_row(changed_row, row, factor)
                if fine_debug: print(M)
            
        col +=1

    return M

""" Clear the terminal """
system('clear')

""" DON'T MODIFY """
use_gauss_reduction = False
gauss_rescale_leading_entry = False

variables_are_in_polynomial_ring = True
parameters_are_in_polynomial_ring = True

"""
#################### INIT STOP ####################
"""

"""
#################### CONFIG START ####################
"""

use_rref_instead_of_echelon_form = False

fine_debug = False

"""
#################### CONFIG STOP ####################
"""

"""
#################### USER START ####################
"""

""" Initialize variables """
# x, y, z, h, t, k are declared for default
new_parameters_names = ''
vectors_length = 4

R, Xn_list = declare_variables()

""" Assumptions and assignements """
# if not parameters_are_in_polynomial_ring:
#     assume(h, 'real')
# k = 1

""" Basis vectors as matrix rows """
Content = [
    [1, 1, 1, 1],
    [1, 1, -2, -1]
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
    MEchelon = gauss_method(M)
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
#################### COMPUTATION END ####################
"""
