# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/scons/scons-0.0.2.ebuild,v 1.3 2002/07/11 06:30:25 drobbins Exp $

S=${WORKDIR}/scons-0.02
DESCRIPTION="Extensible python-based build utility"
SRC_URI="mirror://sourceforge/scons/scons-0.02.tar.gz"
HOMEPAGE="http://www.scons.org"

DEPEND=">=dev-lang/python-2.0"
RDEPEND=">=dev-lang/python-2.0"

src_compile() {
	python setup.py build
}

src_install () {
	python setup.py install --root=${D}
	dodoc {CHANGES,LICENSE,README,RELEASE}.txt PKG-INFO MANIFEST
	doman scons.1
}
