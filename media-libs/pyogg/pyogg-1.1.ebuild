# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/pyogg/pyogg-1.1.ebuild,v 1.3 2003/02/13 12:54:06 vapier Exp $

DESCRIPTION="Python bindings for the ogg library"
HOMEPAGE="http://www.andrewchatham.com/pyogg/"
SRC_URI="http://www.andrewchatham.com/pyogg/download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="dev-lang/python
	>=libogg-1.0"

src_compile() {
	./config_unix.py || die
	python setup.py build || die
}

src_install() {
	python setup.py install --prefix ${D}/usr || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
