"""
In short:
	Template for other scripts.
"""

"""
	USER PART
"""

"""
Fill the matrix with the contect, for example:
	x +  y +  z + t = 0
	x + 2y - 2z - t = 0
	x +  y +  z + t = 0
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
Print matrix
"""
print("\nM:")
print(M)
