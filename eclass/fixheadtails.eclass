# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/fixheadtails.eclass,v 1.4 2004/12/10 23:17:11 johnm Exp $
#
# Author John Mylchreest <johnm@gentoo.org>

ECLASS=fixheadtails
INHERITED="$INHERITED $ECLASS"
DEPEND="${DEPEND} >=sys-apps/sed-4"

# ht_fix_all
# This fixes all files within the current directory.
# Do be used in src_unpack ; cd ${S}; ht_fix_all

# ht_fix_file <param> [<param>] [<param>]..
# This fixes the files passed by PARAM
# to be used for specific files. ie: ht_fix_file "${FILESDIR}/mypatch.patch"

do_sed_fix() {
	sed -i \
		-e 's/head -\(.*\)/head -n \1/' \
		-e 's/tail \([-+]\)\(.*\)c/tail -c \1\2/' \
		-e 's/tail \([-+]\)\(.*\)/tail -n \1\2/' ${1} || \
			die "sed ${1} failed"
}

ht_fix_file() {
	local i

	einfo "Replacing obsolete head/tail with POSIX compliant ones"
	for i in "${@}"
	do
		do_sed_fix ${i}
	done
}

ht_fix_all() {
	local MATCHES
	MATCHES="$(grep -l -i -R -e "head -[ 0-9]" -e "tail [+-][ 0-9]" * | sort -u)"
	ht_fix_file ${MATCHES}
}
