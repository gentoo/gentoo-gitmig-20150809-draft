# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/motif.eclass,v 1.1 2003/12/01 15:02:31 lanius Exp $
#
# Heinrich Wednel <lanius@gentoo.org>

ECLASS=motif
INHERITED="$INHERITED $ECLASS"
DEPEND="${DEPEND} >=sys-apps/sed-4"

# Fix all headers to version ${1}
motif_fix_headers() {
	VERSION=${1}

	MATCHES="$(grep -l -i -R -e "#include <Xm" -e "#include <Mrm" -e "#include <uil" * | sort -u)"

	for i in ${MATCHES}
	do
		sed -i -e "s:#include <Xm:#include <Xm/${VERSION}/Xm:g" \
		  -e "s:#include <Mrm:#include <Mrm/${VERSION}/Mrm:g" \
		  -e "s:#include <uil:#include <uil/${VERSION}/uil:g" \
		  ${i}
	done
}
