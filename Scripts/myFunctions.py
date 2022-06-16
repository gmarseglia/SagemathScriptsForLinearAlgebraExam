import sage.all

def double_print(name, M):
	print("\n{}:".format(name))
	print(M)

def matrix_print(M, prefix='', inline=False, name=''):
	if name != '':	print(prefix + name + ':', end='\n')
	print(prefix + '[', end='')

	for i_row in range(0, M.nrows()):
		row_start = prefix if not inline and i_row > 0 else ''
		row_prefix = ' ' if i_row > 0 else ''

		print(row_start + row_prefix + '[', end='')

		for i_col in range(0, M.ncols()):
			if i_col < M.ncols() - 1:
				comma = ', '
			else:
				comma = ''
			print(str(M[i_row][i_col]) + comma, end='')

		row_suffix = ',' if i_row < M.nrows() - 1 else ''
		row_end = '\n' if i_row < M.nrows() - 1 and not inline else ''

		print(']' + row_suffix, end=row_end)

	print(']')