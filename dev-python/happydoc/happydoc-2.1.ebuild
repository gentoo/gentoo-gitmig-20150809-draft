# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/happydoc/happydoc-2.1.ebuild,v 1.12 2005/08/07 13:31:54 hansmi Exp $

inherit distutils

MY_PN="HappyDoc"
MY_PV=${PV//./_}
S=${WORKDIR}/${MY_PN}-r${MY_PV}
DESCRIPTION="tool for extracting documentation from Python sourcecode"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}_r${MY_PV}.tar.gz"
HOMEPAGE="http://happydoc.sourceforge.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="alpha ppc sparc x86"
IUSE=""

DEPEND="virtual/python"

src_install() {
	mydoc="INSTALL.txt LICENSE.txt CHANGES.txt README.txt"
	distutils_src_install

	insinto /usr/share/doc/${PF}
	doins test_happydoc.py

	# manually install its weird documentation tree
	dohtml -r srcdocs/${MY_PN}-r${MY_PV}/*
	dohtml srcdocs/index.html
	dohtml -r srcdocs/home/dhellmann/Personal/Devel/HappyDoc/dist/HappyDoc-r2_1/
}
