"""
    Calcola il polinomio caratteristico di una matrice.
"""

"""
#################### INIT START ####################
"""

""" Reset """
reset()
os.system('clear')

""" Import and define """
load("myModule.sage")

fine_debug = False

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
Content = [
    [-7, 2, 5],
    [-11, 4, 7],
    [-8, 2, 6]
]

# Create the matrix
M = matrix(Content)
double_print("M", M)

# Compute the factored characteristic polynomial
It = identity_matrix(M.nrows()) * t
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
#################### USER END ####################
"""
