# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymad/pymad-0.5.4.ebuild,v 1.11 2011/01/29 16:40:08 armin76 Exp $

inherit distutils

DESCRIPTION="Python wrapper for libmad MP3 decoding in python"
HOMEPAGE="http://www.spacepants.org/src/pymad/"
SRC_URI="http://www.spacepants.org/src/pymad/download/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

DEPEND="media-libs/libmad"

DOCS="AUTHORS THANKS"

src_compile() {
	./config_unix.py --prefix /usr || die
	distutils_src_compile
}
