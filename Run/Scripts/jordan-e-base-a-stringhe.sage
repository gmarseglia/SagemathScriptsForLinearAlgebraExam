"""
    Calcola la forma di Jordan e la base a stringhe.s
"""

"""
#################### INIT START ####################
"""

""" Reset """
reset()
os.system('clear')

""" Import and define """
load("myModule.sage")

use_manual_instead_of_sage = True

""" Initialize variables """
# x, y, z, h, t, k are declared for default
R, Xn_list = declare_variables(vectors_length = 4, new_parameters_names = '',
    variables_are_in_polynomial_ring = False, parameters_are_in_polynomial_ring = False)

"""
#################### INIT STOP ####################
"""

"""
#################### USER START ####################
"""

Content = [
    [1, 1, 1, 0],
    [0, 0, 0, 1],
    [0, -1, 0, 0],
    [1, 0, 1, 0]
]

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
#################### USER END ####################
"""
