"""
    Diagonalizza una matrice.
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
R, Xn_list = declare_variables(vectors_length = 3, new_parameters_names = '',
    variables_are_in_polynomial_ring = False, parameters_are_in_polynomial_ring = False)

"""
#################### INIT STOP ####################
"""

"""
#################### USER START ####################
"""

""" Content """
Content = [
    [-7,    2,  5],
    [-11,   4,  7],
    [-8,    2,  6],
]

# Create the matrix
M = matrix(Content)
double_print("M", M)

D, P = M.eigenmatrix_right()
double_print("D", D)
double_print("P", P)
double_print("P^-1", P^-1)

"""
#################### USER END ####################
"""
