# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymad/pymad-0.5.4.ebuild,v 1.7 2006/10/21 01:19:55 agriffis Exp $

inherit distutils

DESCRIPTION="Python wrapper for libmad MP3 decoding in python"
HOMEPAGE="http://www.spacepants.org/src/pymad/"
SRC_URI="http://www.spacepants.org/src/pymad/download/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"

DEPEND="virtual/python
	media-sound/madplay"

DOCS="AUTHORS NEWS THANKS"

src_compile() {
	./config_unix.py --prefix /usr || die
	distutils_src_compile
}

