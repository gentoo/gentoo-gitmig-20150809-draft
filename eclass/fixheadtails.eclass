# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/fixheadtails.eclass,v 1.8 2005/07/06 20:23:20 agriffis Exp $
#
# Author John Mylchreest <johnm@gentoo.org>

DEPEND="${DEPEND} >=sys-apps/sed-4"

# ht_fix_all
# This fixes all files within the current directory.
# Do be used in src_unpack ; cd ${S}; ht_fix_all

# ht_fix_file <param> [<param>] [<param>]..
# This fixes the files passed by PARAM
# to be used for specific files. ie: ht_fix_file "${FILESDIR}/mypatch.patch"

do_sed_fix() {
	einfo " - fixed $1"
	sed -i \
		-e 's/head \+-\([0-9]\)/head -n \1/g' \
		-e 's/tail \+\([-+][0-9]\+\)c/tail -c \1/g' \
		-e 's/tail \+\([-+][0-9]\)/tail -n \1/g' ${1} || \
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
	[[ -n ${MATCHES} ]] \
		&& ht_fix_file ${MATCHES} \
		|| einfo "No need for ht_fix_all anymore !"
}
