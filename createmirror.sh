#!/bin/bash

T="$(date +%s%N)"

echo "* Start for mratwork.repo mirror"

if [ ! -d ./repo/mratwork ] ; then
	cd ../../
fi

echo "  - Removing '.repodata' dirs and 'index.html' files"
find ./repo/ -type d -name ".repodata" -exec rm -rf {} \; >/dev/null 2>&1
find ./repo/ -type f -name "index.html" -exec rm -rf {} \; >/dev/null 2>&1

echo "  - Getting rpms files"
wget -R index.html*,.repodata -m -nH -x http://rpms.mratwork.com/repo/mratwork/

echo "* End for mratwork.repo mirror"

# Time interval in nanoseconds
T="$(($(date +%s%N)-T))"
# Seconds
S="$((T/1000000000))"
# Milliseconds
M="$((T/1000000))"

echo ""
printf "*** Process Time: %02d:%02d:%02d:%02d.%03d (dd:hh:mm:ss:xxxxxx) ***\n" \
	"$((S/86400))" "$((S/3600%24))" "$((S/60%60))" "$((S%60))" "${M}"
echo ""
