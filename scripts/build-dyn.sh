#!/bin/bash
x86_ver=1.0
sparc_ver=1.0
sparc64_ver=1.0
unamem=`uname -m`

case `uname -m` in
	sparc64)	profile=default-sparc64-${sparc64_ver}		;;
	sparc)		profile=default-sparc-${sparc_ver}			;;
	i[0-9]86)	profile=default-${x86_ver}					;;
esac

profiledir=/usr/portage/profiles/${profile}

for x in `cat ${profiledir}/packages.build`
do
	grep -E "${x}(-[^[:space:]]*)?[[:space:]]*$" ${profiledir}/packages \
		| grep -v '^#' | sed -e 's:^\*::' | cat 
done
