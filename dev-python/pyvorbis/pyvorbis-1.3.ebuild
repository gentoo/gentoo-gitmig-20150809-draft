# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyvorbis/pyvorbis-1.3.ebuild,v 1.15 2007/07/11 06:19:47 mr_bones_ Exp $

inherit distutils

DESCRIPTION="Python bindings for the ogg.vorbis library"
HOMEPAGE="http://www.andrewchatham.com/pyogg/"
#SRC_URI="http://www.andrewchatham.com/pyogg/download/${P}.tar.gz"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ppc ppc64 sparc x86"
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
