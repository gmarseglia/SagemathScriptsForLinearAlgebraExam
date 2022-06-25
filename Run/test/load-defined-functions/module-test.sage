reset()
os.system('clear')

load("myModule.sage")

R, Xn_list = declare_variables(4, '', False, False)

M = matrix(QQ, 3, 3, [1, 1, 1, 1, 0, 1, 0, 1, 1])
M_echelon = gauss_method(M, fine_debug=False)

matrix_print(M, 'M')
matrix_print(M_echelon, 'M_echelon')
