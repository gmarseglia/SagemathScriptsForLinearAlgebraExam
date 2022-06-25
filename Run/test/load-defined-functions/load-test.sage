""" Reset """
from sage.misc.reset import reset
reset()

load("myModule.sage")

def main():
	M = matrix(QQ, 2, 2, 5)
	matrix_print("M", M)