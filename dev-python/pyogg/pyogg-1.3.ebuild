# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyogg/pyogg-1.3.ebuild,v 1.4 2003/12/26 14:27:07 weeve Exp $

inherit distutils

DESCRIPTION="Python bindings for the ogg library"
HOMEPAGE="http://www.andrewchatham.com/pyogg/"
SRC_URI="http://www.andrewchatham.com/pyogg/download/${P}.tar.gz"

IUSE=""
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc"

DEPEND="dev-lang/python
	>=media-libs/libogg-1.0"

src_compile() {
	./config_unix.py || die
	distutils_src_compile
}

DOCS="AUTHORS COPYING ChangeLog NEWS README"

