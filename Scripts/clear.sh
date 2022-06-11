# !/bin/bash
for d in $(find . -type d -name "__pycache__") ; do
	trash "$d"
	echo "$d deleted."
done

for f in $(find . -type f -name "*.sage.py") ; do
	trash "$f"
	echo "$f deleted."
done

for f in $(find . -type f -name "*.old") ; do
	trash "$f"
	echo "$f deleted."
done

printf "Done.\n\n"
