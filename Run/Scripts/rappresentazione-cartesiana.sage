"""
    Calcola la rappresentazione cartesiana dati i vettori.
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

""" Non modifiable boolean DON'T MODIFY """
variables_are_in_polynomial_ring = True
parameters_are_in_polynomial_ring = True
use_gauss_reduction = False
gauss_rescale_leading_entry = False
use_rref_instead_of_echelon_form = False
fine_debug = False

""" Initialize variables """
# x, y, z, h, t, k are declared for default
R, Xn_list = declare_variables(vectors_length = vectors_length, new_parameters_names = '',
    variables_are_in_polynomial_ring = variables_are_in_polynomial_ring, 
    parameters_are_in_polynomial_ring = parameters_are_in_polynomial_ring)


"""
#################### INIT STOP ####################
"""

"""
#################### USER START ####################
"""

""" Basis vectors as matrix rows """
Content = [
    [1, 1, 0, 1],
    [1, 1, 2, 3]
]

""" Create the matrix """
M = matrix(QQ, Content)

""" Create variables vector """
if vectors_length <= 3:
    Xn = vector([x, y, z])
else:
    if not variables_are_in_polynomial_ring:
        Xn = vector(Xn_list[3:3+vectors_length])
    else:
        Xn = vector(R.gens()[3:3+vectors_length])
double_print("Xn", Xn)

double_print("M", M)
double_print("rank(M)", M.rank())
double_print("Xn", Xn)

""" Create matrix that will define the constraints """
M_stacked_transposed = M.stack(matrix([Xn])).transpose()
double_print("M_stacked_transposed", M_stacked_transposed)

""" Reduce the matrix to the echelon form """
message = "MFinal "
if use_gauss_reduction:
    message += "(using gauss_method)"
    MFinal = gauss_method(M_stacked_transposed, gauss_rescale_leading_entry, fine_debug)
else:
    if use_rref_instead_of_echelon_form:
        message += "(using .rref())"
        MFinal = M_stacked_transposed.rref()
    else:
        message += "(using .echelonize())"
        MFinal = copy(M_stacked_transposed)
        MFinal.echelonize()

double_print(message, MFinal)

print("\nConstraints:")
for i in range(M.rank(), MFinal.nrows()):
    print("{} == 0".format(MFinal[i][MFinal.ncols()-1]))

"""
#################### USER END ####################
"""
