# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/scons/scons-0.0.7.ebuild,v 1.4 2002/08/16 04:04:42 murphy Exp $

MY_P=${PN}-0.07
S=${WORKDIR}/${MY_P}
DESCRIPTION="Extensible python-based build utility"
SRC_URI="mirror://sourceforge/scons/${MY_P}.tar.gz"
HOMEPAGE="http://www.scons.org"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=dev-lang/python-2.0"

src_compile() {
	python setup.py build
}

src_install () {
	python setup.py install --root=${D}
	dodoc *.txt PKG-INFO MANIFEST
	doman scons.1
}
