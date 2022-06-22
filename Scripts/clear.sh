# !/bin/bash
for d in $(find . -type d -name "__pycache__" -or -name ".ipynb_checkpoints") ; do
	trash "$d"
	echo "$d deleted."
done

for f in $(find . -type f -name "*.sage.py" -or -name "*.old") ; do
	trash "$f"
	echo "$f deleted."
done

printf "Done.\n\n"
