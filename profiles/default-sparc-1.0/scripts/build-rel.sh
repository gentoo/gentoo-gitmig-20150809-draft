#!/bin/sh
#
# $Header: /var/cvsroot/gentoo-x86/profiles/default-sparc-1.0/scripts/build-rel.sh,v 1.5 2002/09/02 23:04:30 murphy Exp $
#
# Where we get the sauce
: ${SOURCE:=../default-x86-2.0}

# New packages file
FILES="packages.build use.defaults packages make.defaults virtuals"

keepfile() {
	FILE=${1}
	if [ -s .${FILE}.keep.6 ]; then rm .${FILE}.keep.6; fi
	if [ -s .${FILE}.keep.5 ]; then mv .${FILE}.keep.5 .${FILE}.keep.6; fi
	if [ -s .${FILE}.keep.4 ]; then mv .${FILE}.keep.4 .${FILE}.keep.5; fi
	if [ -s .${FILE}.keep.3 ]; then mv .${FILE}.keep.3 .${FILE}.keep.4; fi
	if [ -s .${FILE}.keep.2 ]; then mv .${FILE}.keep.2 .${FILE}.keep.3; fi
	if [ -s .${FILE}.keep.1 ]; then mv .${FILE}.keep.1 .${FILE}.keep.2; fi
	if [ -s .${FILE}.keep   ]; then   mv .${FILE}.keep .${FILE}.keep.1; fi
	if [ -s ${FILE} ]; then cp -p ${FILE} .${FILE}.keep; fi
}

for f in $FILES; do
	if [ -s ${SOURCE}/${f} ]; then
		echo -n "${f}: keep"
		keepfile $f
		if [ -r ${f} ]; then
			rm ${f}
			touch ${f}
		fi
		if [ -s ${f}.sed ]; then
			echo -n " sed"
			sed -f ${f}.sed ${SOURCE}/${f} | \
				egrep -e '[^\s]+' >> ${f}
		else
			echo -n " cat"
			cat ${SOURCE}/${f} >> ${f}
		fi
		if [ -s ${f}.sparc ]; then
			echo -n " sparc"
			cat ${f}.sparc >> ${f}
		fi
		echo " ok"
	fi
done
