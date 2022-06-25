"""
    Customized Sage functions.
"""

""" Print the matrix, prefixed by its name. """
def double_print(name, M):
        print("\n{}:\n".format(name), end='')
        print(M)

""" Print matrix with more control. """
def matrix_print(M, name='', prefix='', inline=False, newline=True, between_entries=','):
    rjust_count = 0
    for i_row in range(0, M.nrows()):
        for i_col in range(0, M.ncols()):
            entry_len = len(str(M[i_row][i_col]))
            if entry_len > rjust_count: rjust_count = entry_len
    rjust_count += 1

    if newline: print('\n', end='')

    if name != '':  print(prefix + name + ':', end='\n')
    print(prefix + '[', end='')

    for i_row in range(0, M.nrows()):
        row_start = prefix if not inline and i_row > 0 else ''
        row_prefix = ' ' if i_row > 0 else ''

        print(row_start + row_prefix + '[', end='')

        for i_col in range(0, M.ncols()):
            if i_col < M.ncols() - 1:
                separator = between_entries
            else:
                separator = ''
            print(str(M[i_row][i_col]).rjust(rjust_count) + separator, end='')

        row_suffix = ',' if i_row < M.nrows() - 1 else ''
        row_end = '\n' if i_row < M.nrows() - 1 and not inline else ''

        print(']' + row_suffix, end=row_end)

    print(']')

""" Declare and inject all variables automatically. """
def declare_variables(vectors_length, new_parameters_names='',
    variables_are_in_polynomial_ring=False, parameters_are_in_polynomial_ring=False):

    """ Declare variables """
    variables_names = ''
    parameters_names = ""
    symbolic_names = ""
    polynomial_ring_names = ""
    Xn_list = []
    R = false

    """ Add all variables names """
    # Add x, y, z
    variables_names += 'x, y, z'
    # Add x0, x1, ... if needed
    if vectors_length > 3:
        for i in range(0, vectors_length):
            variables_names += (', x' + str(i))

    """ Add all parameters names """
    # Add h, t, k
    parameters_names += 'h, t, k'
    # Add new_parameters_names if present
    if new_parameters_names != '':
        parameters_names += ', ' + new_parameters_names

    """ Combine according to boolean in symbolic names and
        polynomial ring names """
    if variables_are_in_polynomial_ring:
        polynomial_ring_names += variables_names
    else:
        symbolic_names += variables_names

    if parameters_are_in_polynomial_ring:
        if polynomial_ring_names != "" : polynomial_ring_names += ', '
        polynomial_ring_names += parameters_names
    else:
        if symbolic_names != "" : symbolic_names += ', '
        symbolic_names += parameters_names

    """ Declare variables and parameters according to boolean """
    # var() style
    print("\nDeclaring variables:")

    if symbolic_names != "":
        print('\tAs var():\t\t{}'.format(symbolic_names))
        Xn_list = var(symbolic_names)

    # PolynomialRing and inject style
    if polynomial_ring_names != "":
        print('\tWith PolynomialRing:\t{}'.format(polynomial_ring_names))
        R = PolynomialRing(QQ, polynomial_ring_names)
        R.inject_variables(verbose=False)

    return R, Xn_list

""" Naive Gaussian reduction. """
def gauss_method(M, gauss_rescale_leading_entry=False, fine_debug=False):
    """Describe the reduction to echelon form of the given matrix of rationals.

    M  matrix of rationals   e.g., M = matrix(QQ, [[..], [..], ..])
    rescale_leading_entry=False  boolean  make the leading entries to 1's

    Returns: None.  Side effect: M is reduced.  Note: this is echelon form, 
    not reduced echelon form; this routine does not end the same way as does 
    M.echelon_form().

    """
    num_rows=M.nrows()
    num_cols=M.ncols()
    
    if fine_debug:
        if gauss_rescale_leading_entry:
            print("\nInitiating Gauss Reduction (with rescale leading entry)")
        else:
            print("\nInitiating Gauss Reduction")
        double_print("Starting matrix", M)  

    col = 0   # all cols before this are already done
    for row in range(0,num_rows): 
        # ?Need to swap in a nonzero entry from below
        while (col < num_cols and M[row][col] == 0): 
            for i in M.nonzero_positions_in_column(col):
                if i > row:
                    if fine_debug: print(" Swap row",row+1,"with row",i+1)
                    M = M.with_swapped_rows(row,i)
                    if fine_debug: print(M)
                    break     
                else:
                    col += 1

        if col >= num_cols:
            break

        # Now guaranteed M[row][col] != 0
        q=1/M[row][col]
        try:
            q_is_real = q.is_real()
        except:
            q_is_real = false
        test = (not q == 1) and (q in QQ or q_is_real)
        # print('q: {}, test: {}'.format(q, test))
        if (gauss_rescale_leading_entry and test):
            if fine_debug: print(" Row",row+1,"times", q)
            M = M.with_rescaled_row(row, q)
            if fine_debug: print(M)

        for changed_row in range(row+1,num_rows):
            if not M[changed_row][col] == 0:
                factor=-1*M[changed_row][col]/M[row][col]
                if fine_debug: print(" Row",changed_row+1,"plus", factor, "times row", row+1)
                M = M.with_added_multiple_of_row(changed_row, row, factor)
                if fine_debug: print(M)
            
        col +=1

    return M