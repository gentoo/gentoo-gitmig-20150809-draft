# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/scons/scons-0.94.ebuild,v 1.1 2003/11/17 01:37:16 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Extensible python-based build utility"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://www.scons.org"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~amd64 ~ia64"

DEPEND=">=dev-lang/python-2.0"

src_compile() {
	python setup.py build
}

src_install () {
	python setup.py install --root=${D}
	dodoc *.txt PKG-INFO MANIFEST
	doman scons.1
}
