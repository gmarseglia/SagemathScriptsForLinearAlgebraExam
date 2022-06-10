import sage.all

def double_print(name, M):
	print("\n{}:".format(name))
	print(M)

def declare_xyzt():
	return sage.all.var('x, y, z, t')