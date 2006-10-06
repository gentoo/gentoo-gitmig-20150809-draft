# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pydns/pydns-2.3.0.ebuild,v 1.1 2006/10/06 22:01:09 sbriesen Exp $

inherit eutils distutils multilib

DESCRIPTION="Python DNS library"
HOMEPAGE="http://pydns.sourceforge.net/"
SRC_URI="mirror://sourceforge/pydns/${P}.tgz"

LICENSE="CNRI"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="virtual/python"

PYTHON_MODNAME="DNS"

fix_encoding() {
	local TMPFILE="${1}~"
	case "${1}" in
		*.py)
			echo "# -*- coding: ${3} -*-" > "${TMPFILE}"
			;;
	esac
	iconv -f "${2}" -t "${3}" < "${1}" >> "${TMPFILE}" \
		&& mv -f "${TMPFILE}" "${1}" \
		|| rm -f "${TMPFILE}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix encodings
	for i in *.txt "${PYTHON_MODNAME}"/*.py; do
		fix_encoding "${i}" "iso-8859-1" "utf-8"
	done
}

src_install(){
	distutils_src_install
	rm -f ${D}usr/$(get_libdir)/python*/site-packages/${PYTHON_MODNAME}/*.py[co]

	dodoc CREDITS.txt

	if use doc; then
		insinto /usr/share/doc/${PF}/examples
		doins tests/*.py tools/*.py
	fi
}
