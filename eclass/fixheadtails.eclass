# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/fixheadtails.eclass,v 1.1 2003/09/17 21:15:18 johnm Exp $
#
# Author John Mylchreest <johnm@gentoo.org>

ECLASS=fixheadtails
INHERITED="$INHERITED $ECLASS"

# ht_fix_all
# This fixes all files within the current directory.
# Do be used in src_unpack ; cd ${S}; ht_fix_all

# ht_fix_file <param> [<param>] [<param>]..
# This fixes the files passed by PARAM
# to be used for specific files. ie: ht_fix_file "${FILESDIR}/mypatch.patch"

ht_fix_all() {
	local MATCHES

	einfo "Replacing obsolete head/tail with posix compliant ones"
	for MATCHES in $(grep -i -R -e "head -[ 0-9]" -e "tail [+-][ 0-9]" * | cut -f1 -d: | sort -u) ; do
		cp -f ${MATCHES} ${MATCHES}.orig
        	sed -e 's/head -\(.*\)/head -n \1/' -e 's/tail \([-+]\)\(.*\)/tail -n \1\2/' \
			< ${MATCHES}.orig \
        		> ${MATCHES}
		rm ${MATCHES}.orig
	done
}

ht_fix_file() {
	local i

	einfo "Replacing obsolete head/tail with posix compliant ones"
	for i in "${@}"
	do
		if [ -n "$(grep -i -e "head -[ 0-9]" -e "tail [+-][ 0-9]" ${i})" ] ; then
			cp -f ${i} ${i}.orig
			sed -e 's/head -\(.*\)/head -n \1/' -e 's/tail \([-+]\)\(.*\)/tail -n \1\2/' \
				< ${i}.orig \
				> ${i}
			rm ${i}.orig
		fi
	done
eend
}
