# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Julien Herfurth <jherfurth@arafox.com>
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-xmlrpc/py-xmlrpc-0.8.7.ebuild,v 1.1 2002/04/13 21:18:16 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Fast xml-rpc implementation for Python"
SRC_URI="http://prdownloads.sourceforge.net/py-xmlrpc/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/py-xmlrpc/"

DEPEND="virtual/python"
RDEPEND="$DEPEND"

src_compile() {
	python setup.py build || die
}

src_install () {
	python setup.py install --prefix=${D}/usr || die
	dodoc CHANGELOG COPYING INSTALL README
	dodoc doc/*
	docinto example
	dodoc doc/example/*
}
