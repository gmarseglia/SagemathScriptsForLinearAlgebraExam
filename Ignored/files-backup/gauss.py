# Naive Gaussian reduction
def gauss_method(M):
    """Describe the reduction to echelon form of the given matrix of rationals.

    M  matrix of rationals   e.g., M = matrix(QQ, [[..], [..], ..])
    gauss_rescale_leading_entry=False  boolean  make the leading entries to 1's

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
    for row in range(0, num_rows):
        # ?Need to swap in a nonzero entry from below
        while (col < num_cols and M[row][col] == 0):
            for i in M.nonzero_positions_in_column(col):
                if i > row:
                    M.swap_rows(row,i)
                    if fine_debug: 
                        print(" Swap row",row+1,"with row",i+1)
                        print(M)
                    break     
            else:
                col += 1

            if col >= num_cols:
                break

    print(M[row][col])
    if(gauss_rescale_leading_entry and M[row][col] != 1):
        print("[{}][{}]".format(row, col))
        q = 1/M[row][col]
        if q in QQ:
            M.rescale_row(row, q)
            if fine_debug:
                print(" Row",row+1,"times", q)
                print(M)

    for changed_row in range(row+1,num_rows):
        if M[changed_row][col] != 0:
            factor=-1*M[changed_row][col]/M[row][col]
            if fine_debug: print(" Row",changed_row+1,"plus", factor, "times row", row+1)
            M.add_multiple_of_row(changed_row,row,factor)
            if fine_debug: print(M)
    
    col +=1