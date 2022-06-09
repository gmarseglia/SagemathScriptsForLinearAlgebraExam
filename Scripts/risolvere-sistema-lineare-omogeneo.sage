"""
In short:
	Calcola una base dello spazio vettoriale data la sua rappresentazione cartesiana
	Utente dovrebbe solo modificare la user part.
"""

"""
	USER PART
"""

"""
Fill the matrix with the contect, for example:
	x +  y +  z + t = 0
	x + 2y - 2z - t = 0
"""
Content = [
	[1, 1,  1,  1],
	[1, 2, -2, -1],
	[1, 1,  1,  1]
]

"""
	AUTOMATION PART
"""

from os import system

"""
Clear the terminal and set the debug print level
"""
fine_debug = false
system('clear')

"""
Declare variables
"""
x, y, t, z = var('x, y, t, z')


"""
Create the matrix
"""
M = matrix(Content)
# M = matrix(RDF, Content)

"""
Print functions and matrix
"""
# XM is a matrix 1x4 containing the variables
# X is a vector the same size as the ncols of M
# for example M = [[1,2,3],[4,5,6]] -> X = (x, y, z) 
XM = Matrix(SR, [x, y, z, t])
X = XM.submatrix(0,0,1,M.ncols()).row(0)

print("\nFunctions: ! Watch out for order !")
for i in range(0, M.nrows()):
	print(X.dot_product(M.row(i)) == 0)
print("\nM:")
print(M)

"""
Echelonize the matrixm and print
"""
# .rref() is preferred because use fractions
# M_ECHELON = M.echelon_form()
M_ECHELON = M.rref()
print("\nM_ECHELON:")
print(M_ECHELON)

"""
Remove 0 rows
"""
# All 0 rows are deleted to ensure the basis vector are correct in size
M_ECHELON = M_ECHELON.submatrix(0, 0, M_ECHELON.rank(), M_ECHELON.ncols())

"""
Compute the pivots and print
"""
pivots_columns = M_ECHELON.pivots()
pivots_rows = M_ECHELON.pivot_rows()
pivots = []
for i in range(0, len(pivots_columns)):
	pivots.append((pivots_columns[i], pivots_rows[i]))
print("\npivots:\n", pivots)

"""
Change the sign of the columns that are not pivots
"""
# This is part of the algorithm
M_SIGN_CHANGED = copy(M_ECHELON)
not_pivots_columns = []
for i in range(0, M_SIGN_CHANGED.ncols()):
	if not i in pivots_columns:
		M_SIGN_CHANGED.rescale_col(i, -1)
		not_pivots_columns.append(i)
	
"""
Compute the final matrix that will have the basis vector as its columns
"""
# This part is a bit confusing but in short M_FINAL is a matrix with basis vectors as its columns
M_ONLY_NOT_PIVOTS	= M_SIGN_CHANGED.matrix_from_columns(not_pivots_columns)
MM_SPACE = MatrixSpace(M_ONLY_NOT_PIVOTS.base_ring(), M_ONLY_NOT_PIVOTS.ncols(), M_ONLY_NOT_PIVOTS.ncols())
M_FINAL = M_ONLY_NOT_PIVOTS.stack(MM_SPACE.identity_matrix())

if fine_debug:
	print('\nM_SIGN_CHANGED:')
	print(M_SIGN_CHANGED)

	print("\nM_ONLY_PIVOTS:")
	print(M_ONLY_PIVOTS)

	print("\nM_ONLY_NOT_PIVOTS:")
	print(M_ONLY_NOT_PIVOTS)

	print("\nM_FINAL:")
	print(M_FINAL)

"""
Print the basis
"""
print("\nBasis:")
for i in range(0, M_FINAL.ncols()):
	print(M_FINAL.column(i))
