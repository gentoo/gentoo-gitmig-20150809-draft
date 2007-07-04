# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/happydoc/happydoc-2.1-r1.ebuild,v 1.2 2007/07/04 19:50:49 hawking Exp $

inherit distutils eutils

MY_PN="HappyDoc"
MY_PV=${PV//./_}
S=${WORKDIR}/${MY_PN}-r${MY_PV}
DESCRIPTION="tool for extracting documentation from Python sourcecode"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}_r${MY_PV}.tar.gz"
HOMEPAGE="http://happydoc.sourceforge.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="alpha ~amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="virtual/python"

# the tests need extra data not present in the release tarball
RESTRICT=test

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-python-2.4-compat.patch"
}

src_install() {
	DOCS="CHANGES.txt"
	distutils_src_install

	insinto /usr/share/doc/${PF}
	doins test_happydoc.py

	# manually install its weird documentation tree
	dohtml -r srcdocs/${MY_PN}-r${MY_PV}/*
	dohtml srcdocs/index.html
	dohtml -r srcdocs/home/dhellmann/Personal/Devel/HappyDoc/dist/HappyDoc-r2_1/
}
