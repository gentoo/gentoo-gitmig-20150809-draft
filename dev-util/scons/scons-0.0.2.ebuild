# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/scons/scons-0.0.2.ebuild,v 1.1 2002/01/02 00:18:48 karltk Exp $

S=${WORKDIR}/scons-0.02
DESCRIPTION="Extensible python-based build utility"
SRC_URI="http://prdownloads.sourceforge.net/scons/scons-0.02.tar.gz"
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
