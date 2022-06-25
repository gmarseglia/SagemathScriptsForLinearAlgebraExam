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

def clear_bottom_rows_and_right_columns_from_pivot(M, pivot_row, pivot_col, fine_debug = False):
    for i_row in range(pivot_row + 1, M.nrows()):
        factor = - (M[i_row][pivot_col] / M[pivot_row][pivot_col])
        M.add_multiple_of_row(i_row, pivot_row, factor)
        if fine_debug:
            matrix_print(M, 'M after: row {} + {} times row {}'.format(i_row, factor, pivot_row))
        M.add_multiple_of_column(i_row, pivot_row, factor)
        if fine_debug:
            matrix_print(M, 'M after: column {} + {} times column {}'.format(i_row, factor, pivot_row))


def gauss_lagrange_method(G, fine_debug = False):
    GI = G.augment(identity_matrix(G.nrows()), subdivide = True)
    print('\nGI:\n', end='')
    print(GI)

    for i_col in range(0, GI.nrows()):
    # for i_col in range(0, 1):
        if GI.column(i_col) == 0:
            continue

        j = i_col
        i = GI.nonzero_positions_in_column(j)[0]

        while i != j:
            GI.add_multiple_of_row(j, i, 1)
            matrix_print(GI, 'GI after: row {} + {} times row {}'.format(j, 1, i))
            GI.add_multiple_of_column(j, i, 1)
            matrix_print(GI, 'GI after: column {} + {} times column {}'.format(j, 1, i))

            double_print('GI', GI)

            j = i_col
            i = GI.nonzero_positions_in_column(j)[0]

        print('\nPivot found at [{}][{}]'.format(i,j))

        clear_bottom_rows_and_right_columns_from_pivot(GI, i, j, True)

        double_print('GI', GI)

    return GI

# G_content = [[6, -1, 3],
#             [-1, 2, 1],
#             [3, 1, 6]]

G_content = [[0, -2, 3],
            [-2, 6, -10],
            [3, -10, 8]]

G = matrix(QQ, 3, 3, G_content)

matrix_print(G, 'G')

#clear_bottom_rows_and_right_columns_from_pivot(G, 0, 0, fine_debug = True)

matrix_print(G, 'G')

GI = gauss_lagrange_method(G, fine_debug = True)


"""
#################### USER END ####################
"""
