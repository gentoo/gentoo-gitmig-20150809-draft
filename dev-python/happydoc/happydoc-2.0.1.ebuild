# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/happydoc/happydoc-2.0.1.ebuild,v 1.12 2003/04/26 19:36:36 liquidx Exp $

MY_PN="HappyDoc"
MY_PV=${PV//./_}
S=${WORKDIR}/${MY_PN}-r${MY_PV}
DESCRIPTION="tool for extracting documentation from Python sourcecode"
SRC_URI="mirror://sourceforge/happydoc/${MY_PN}_r${MY_PV}.tar.gz"
HOMEPAGE="http://happydoc.sourceforge.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc alpha"

DEPEND="virtual/python"

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --root=${D} --prefix=/usr || die
	dodoc INSTALL.txt LICENSE.txt CHANGES.txt README.txt test_happydoc.py
	dohtml -r srcdocs/*
}
