"""
    Nuovo template.
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

for M_switch in (True, False):
    print('\nM_switch: {}'.format(M_switch))

    M_block1 = jordan_block(3, 2)
    M_block2 = jordan_block(2, 3)
    if not M_switch:
        M = M_block1.block_sum(M_block2)
    else:
        M = M_block2.block_sum(M_block1)

    M[2, 2] = 0

    N = jordan_block(4, 2).block_sum(jordan_block(5, 3))

    double_print('M', M)
    print(M.eigenspaces_right())
    double_print('N', N)

    MN = M * N
    double_print('MN', MN)
    print(MN.eigenspaces_right())

    NM = N * M
    double_print('NM', NM)
    print(NM.eigenspaces_right())


"""
#################### USER END ####################
"""
