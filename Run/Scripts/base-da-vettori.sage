"""
    Calcola una base dati i vettori.
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

use_gauss_reduction = True
gauss_rescale_leading_entry = True

use_rref_instead_of_echelon_form = False

fine_debug = False

"""
#################### INIT STOP ####################
"""

"""
#################### USER START ####################
"""

""" Matrix with vectors as rows """
Content = [
    [1, 1, 1, h],
    [0, 1, 1, 1],
    [1, 2, 2, 2]
]

""" Create the matrix """
M = matrix(QQ, Content)
double_print("M", M)

""" Print vectors """
print("\nRows:")
for row in M.rows():
    print(row)

""" Print echelon_form and rref """
MEchelon = copy(M)
MEchelon.echelonize()
MRref = M.rref()
MGauss = gauss_method(M, gauss_rescale_leading_entry = gauss_rescale_leading_entry,
    fine_debug = fine_debug)

double_print("MEchelon", MEchelon)
double_print("MRref", MRref)
double_print("MGauss", MGauss)

""" Print basis """
message = "\nBasis "
if use_gauss_reduction:
    message += "(using gauss_method)"
    MTarget = MGauss
else:
    if use_rref_instead_of_echelon_form:
        message += "(using .rref())"
        MTarget = MRref
    else:
        message += "(using .echelonize())"
        MTarget = MEchelon

print(message + ":")
for row in MTarget.rows():
    if row != 0 :
        print(row)

"""
#################### USER END ####################
"""
