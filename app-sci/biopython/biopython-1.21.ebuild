# Copyright 1999-20022 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/biopython/biopython-1.21.ebuild,v 1.2 2003/09/02 22:45:51 liquidx Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Biopython - python module for Computational Moelcular Biology"
SRC_URI="http://www.biopython.org/files/${P}.tar.gz"
HOMEPAGE="http://www.biopython.org"

DEPEND=">=dev-lang/python-2.0
		>=dev-python/egenix-mx-base-2.0.3
		>=dev-python/numeric-19.0
		>=dev-python/reportlab-1.11"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

src_compile() {
	python setup.py build || die
#	python setup.py test --no-gui || die
}

src_install() {
	echo y | python setup.py install --prefix=${D}/usr || die

	dodoc PKG-INFO README NEWS LICENSE CONTRIB
	dodoc Doc/* Doc/install/*.txt
	dohtml Doc/install/*.html
	cp -r Doc/examples/ ${D}/usr/share/doc/${PF}/
}
