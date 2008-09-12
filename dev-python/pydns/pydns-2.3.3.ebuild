# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pydns/pydns-2.3.3.ebuild,v 1.1 2008/09/12 13:55:31 sbriesen Exp $

inherit eutils distutils

DESCRIPTION="Python module for DNS (Domain Name Service)"
HOMEPAGE="http://pydns.sourceforge.net/"
SRC_URI="mirror://sourceforge/pydns/${P}.tar.gz"

LICENSE="CNRI"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="virtual/python"
DEPEND="${RDEPEND}
	virtual/libiconv"

PYTHON_MODNAME="DNS"
DOCS="CREDITS.txt"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix encodings (should be utf-8 but is latin1)
	for i in CREDITS.txt "${PYTHON_MODNAME}"/{Lib,Type}.py; do
		iconv -f ISO-8859-1 -t UTF-8 < "${i}" > "${i}~" && mv -f "${i}~" "${i}" || rm -f "${i}~"
	done

	# fix setup.cfg (do not compile bytecode!)
	sed -i -e 's:^\(compile\).*:\1 = 0:g' -e 's:^\(optimize\).*:\1 = 0:g' setup.cfg

	# fix python path in examples
	sed -i -e 's:#!/.*\(python\)/*$:#!/usr/bin/\1:g' {tests,tools}/*.py
}

src_install(){
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins tests/*.py tools/*.py
	fi
}
