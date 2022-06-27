"""
    Algoritmo di Gauss-Lagrange.
"""

"""
#################### INIT START ####################
"""

""" Reset """
reset()
os.system('clear')

""" Import and define """
load("myModule.sage")

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

G_content = [[6, -1, 3],
            [-1, 2, 1],
            [3, 1, 6]]

# G_content = [[0, -2, 3],
#             [-2, 6, -10],
#             [3, -10, 8]]

# G_content = [[1, 1, 1],
#             [1, 0, 1],
#             [1, 1, 1]]

# G_content = [[0, 1/2],  [1/2, 0]]

G = matrix(QQ, G_content)

matrix_print(G, 'G')

GI, D, P = gauss_lagrange_method(G, fine_debug = True)

print("\nAfter Gauss-Lagrange:")
matrix_print(GI, 'GI', prefix='\t')
matrix_print(D, 'D', prefix='\t')
matrix_print(P, 'P', prefix='\t')


"""
#################### USER END ####################
"""
