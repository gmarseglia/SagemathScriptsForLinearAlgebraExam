"""
    Moltiplica due matrici fra di loro.
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

""" Content """
A_Content = [
    [2, -1, 2],
    [1, -1, 1]
]

B_Content = [
    [1, -1],
    [2, -1],
    [-1, 0]
]

# Create the matrixes
A = matrix(A_Content)
B = matrix(B_Content)

double_print("A", A)
double_print("B", B)

Final = B * A
double_print("Final", Final)

"""
#################### USER END ####################
"""
