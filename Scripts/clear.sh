# !/bin/bash
if [ -d "__pycache__" ] ; then
	rm -r "__pycache__"
	echo "__pycache__ deleted."
fi

if [ -e *.sage.py ] ; then
	trash *.sage.py
	echo "*.sage.py deleted."
fi

if [ -e *.old ] ; then
	trash *.old
	echo "*.old deleted."
fi

printf "Done.\n\n"
