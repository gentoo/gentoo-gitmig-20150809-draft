# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyvorbis/pyvorbis-1.3.ebuild,v 1.11 2004/08/30 15:46:51 pvdabeel Exp $

inherit distutils

DESCRIPTION="Python bindings for the ogg.vorbis library"
HOMEPAGE="http://www.andrewchatham.com/pyogg/"
#SRC_URI="http://www.andrewchatham.com/pyogg/download/${P}.tar.gz"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa amd64"
IUSE=""

DEPEND="dev-lang/python
	>=media-libs/libogg-1.0
	>=media-libs/libvorbis-1.0
	>=dev-python/pyogg-1.1"

src_compile() {
	./config_unix.py || die
	distutils_src_compile
}

DOCS="AUTHORS COPYING ChangeLog NEWS README"

