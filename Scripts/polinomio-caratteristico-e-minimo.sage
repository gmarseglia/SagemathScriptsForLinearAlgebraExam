"""
    Calcola il polinomio caratteristico di una matrice.
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

"""
#################### INIT STOP ####################
"""

"""
#################### CONFIG START ####################
"""

use_gauss_reduction = True
gauss_rescale_leading_entry = True

variables_are_in_polynomial_ring = False
parameters_are_in_polynomial_ring = False

use_rref_instead_of_echelon_form = False

use_manual_instead_of_sage = False

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
# k = 0

""" Content """
Content = [
    [-7, 2, 5],
    [-11, 4, 7],
    [-8, 2, 6]
]

"""
#################### USER END ####################
"""

"""
#################### COMPUTATION START ####################
"""

# Create the matrix
M = matrix(Content)
double_print("M", M)

# Compute the factored characteristic polynomial
It = identity_matrix(3) * t
double_print("I_t", It)
MFinal = M - It
double_print("MFinal", MFinal)
pft = MFinal.det()
print("\nCharacterisitc polynomial:")
double_print("pft = det(MFinal)", pft)
double_print("pft.full_simplify()", pft.full_simplify())
double_print("factor(pft)", factor(pft))

if fine_debug:
    double_print("M.charpoly(t) !USE ONLY FOR ROOTS!", M.charpoly(t))
    double_print("M.fcp(t) !USE ONLY FOR ROOTS!", M.fcp(t))

# Compute the minimum polynomial
mft = M.minpoly(t)
print("\nMinimum polynomial:")
double_print("mft = M.minpoly()", mft)
double_print("factor(mft)", factor(mft))

# Compute the eigenvalues
print("\nEigenvalues:")
for eigen_value in M.eigenvalues():
    print("{} with multiplicity {}".format(eigen_value, M.eigenvalue_multiplicity(eigen_value)))

"""
#################### COMPUTATION END ####################
"""
