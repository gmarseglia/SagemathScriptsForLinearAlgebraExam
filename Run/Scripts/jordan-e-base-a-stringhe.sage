"""
    Calcola la forma di Jordan e la base a stringhe.s
"""

"""
#################### INIT START ####################
"""

""" Reset """
from sage.misc.reset import reset
reset()

""" Import and define """
from os import system
from myFunctions import double_print, matrix_print

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

use_manual_instead_of_sage = True

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
vectors_length = 5

R, Xn_list = declare_variables()

""" Assumptions and assignements """
# if not parameters_are_in_polynomial_ring:
#     assume(h, 'real')
# k = 0

""" Content """
# Content = [
#     [0, 0, 2, 1],
#     [0, 2, 1, 1],
#     [0, 0, 2, 1],
#     [0, 0, 0, 2]
# ]

# Content = [
#     [1, 1, 0, 0, 0],
#     [0, 1, 0, 0, 0],
#     [0, 0, 2, 1, 0],
#     [0, 0, 0, 2, 1],
#     [0, 0, 0, 0, 2],
# ]

Content = [
    [1, 1, 1, 0],
    [0, 0, 0, 1],
    [0, -1, 0, 0],
    [1, 0, 1, 0]
]

"""
#################### USER END ####################
"""

"""
#################### COMPUTATION START ####################
"""

M = matrix(QQ, Content)
double_print("M", M)

if use_manual_instead_of_sage:
    pft = factor(det(M - identity_matrix(M.nrows()) * t))
    double_print("pft", pft)

    unique_eigenvalues = list(dict.fromkeys(M.eigenvalues(extend=False)))
    nilpotent_index = 0
    for eigenvalue in unique_eigenvalues:
        if M.eigenvalue_multiplicity(eigenvalue) > nilpotent_index:
            nilpotent_index = M.eigenvalue_multiplicity(eigenvalue)
    double_print("nilpotent_index", nilpotent_index)

    string_basis_vectors = []

    # Eigenvalues
    print("\nEigenvalues:")
    for eigenvalue in unique_eigenvalues:
        print("\nEigen value: {}".format(eigenvalue))

        MEigenvalue = (M - identity_matrix(M.nrows()) * eigenvalue)
        ma = M.eigenvalue_multiplicity(eigenvalue)
        mg = M.nrows() - MEigenvalue.rank()
        Mgeneralized = MEigenvalue ^ ma
        M_basis_generalized = Mgeneralized.right_kernel_matrix(basis='pivot')
        M_be_phi = MEigenvalue * M_basis_generalized.transpose()

        M_bb_phi_vectors = []
        M_basis_generalized_transposed = M_basis_generalized.transpose()
        for i_col in range(0, M_be_phi.ncols()):
            M_bb_phi_vector = M_basis_generalized_transposed.solve_right(M_be_phi.column(i_col))
            M_bb_phi_vectors.append(M_bb_phi_vector)
        M_bb_phi = matrix(Mgeneralized.base_ring(), M_bb_phi_vectors).transpose()

        # M_bb_phi_to_nilpotent_index_minus_1 = M_bb_phi ^ (nilpotent_index - 1)
        M_bb_phi_to_nilpotent_index_minus_1 = M_bb_phi ^ (ma - 1)

        w_vectors = []
        for i_col in range(0, M_bb_phi_to_nilpotent_index_minus_1.ncols()):
            if not M_bb_phi_to_nilpotent_index_minus_1.column(i_col) == 0:
                v = vector(Mgeneralized.base_ring(), M_bb_phi.ncols())
                v[i_col] = 1
                w_vectors.append(v)
                # for i_nilpotent in range(0, nilpotent_index - 1):
                for i_nilpotent in range(0, ma - 1):
                    v = M_bb_phi * v
                    w_vectors.append(v)
        w_vectors.reverse()

        u_vectors = []
        for i in range(0, len(w_vectors)):
            u_vectors.append(w_vectors[i] * M_basis_generalized)

        string_basis_vectors.extend(u_vectors)

        print("\tAlgebric multiplicty {}, Geometric multiplicity {}".format(ma, mg))

        matrix_print(Mgeneralized, \
            name='M generalized for {} == M - (I * {})^{} '.format(eigenvalue, eigenvalue, ma), \
            prefix='\t')
        matrix_print(Mgeneralized.echelon_form(), name='M generalized echelon form', prefix='\t')

        matrix_print(M_basis_generalized, name='M_basis_generalized', prefix='\t')
        # matrix_print(M_be_phi, name='M_be_phi', prefix='\t')

        matrix_print(M_bb_phi, name='M_bb_phi', prefix='\t')

        matrix_print(M_bb_phi_to_nilpotent_index_minus_1, name='M_bb_phi_to_nilpotent_index_minus_1', prefix='\t')

        print('\n\t{}-string basis w vectors (already reversed):\n\t{}'.format(eigenvalue, w_vectors))
        print('\n\t{}-string basis u vectors (already reversed):\n\t{}'.format(eigenvalue, u_vectors))

    M_string = matrix(M.base_ring(), string_basis_vectors).transpose()
    matrix_print(M_string, name='M_string')


else:
    J,P = M.jordan_form(transformation=True)
    print("\n!!! USING SAGE METHODS !!!")
    double_print("J (jordan form)", J)
    double_print("P (matrix with string basis vectors as columns)", P)

"""
#################### COMPUTATION END ####################
"""
