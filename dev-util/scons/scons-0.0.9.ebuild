# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/scons/scons-0.0.9.ebuild,v 1.5 2004/04/19 04:10:32 weeve Exp $

MY_P=${PN}-0.09
S=${WORKDIR}/${MY_P}
DESCRIPTION="Extensible python-based build utility"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://www.scons.org"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc"

DEPEND=">=dev-lang/python-2.0"

src_compile() {
	python setup.py build
}

src_install () {
	python setup.py install --root=${D}
	dodoc *.txt PKG-INFO MANIFEST
	doman scons.1
}
