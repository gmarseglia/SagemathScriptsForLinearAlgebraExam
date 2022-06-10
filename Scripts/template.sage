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

Xn_count = 0

"""
	AUTOMATION PART
"""

from os import system
from myFunctions import declare_xyzt
"""
Clear the terminal and set the debug print level
"""
fine_debug = false
system('clear')

"""
Declare variables
"""
x, y, t, z = declare_xyzt()
Xn = []
for i in range(0, Xn_count):
	Xn.append( var('x' + str(i)) )

"""
Create the matrix
"""
M = matrix(Content)
# M = matrix(RDF, Content)
