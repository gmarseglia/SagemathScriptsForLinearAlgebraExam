"""
In short:
	Template for other scripts.
"""

"""
	USER PART
"""

"""
Fill the matrix with the contect, for example:
	(1, 1, 1, 1)
	(0, 1, 1, 1)
	(1, 2, 2, 2)
"""
Content = [
	[1, 1, 1, 1],
	[0, 1, 1, 1],
	[1, 2, 2, 2]
]

"""
	AUTOMATION PART
"""

from os import system
from myFunctions import double_print

"""
Clear the terminal and set the debug print level
"""
fine_debug = false
system('clear')

"""
Create the matrix
"""
M = matrix(Content)
# M = matrix(RDF, Content)

"""
Print matrix and vectors
"""
print("\nVectors:")
for row in M.rows():
	print(row)
	
double_print("M", M)

M_echelon = M.echelon_form()
M_rref = M.rref()

double_print("M_echelon", M_echelon)
double_print("M_rref", M_rref)

print("\nBasis:")
for row in M_echelon.rows():
	if row != 0 :
		print(row)
