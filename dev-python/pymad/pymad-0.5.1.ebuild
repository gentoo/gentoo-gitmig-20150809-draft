# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymad/pymad-0.5.1.ebuild,v 1.1 2004/02/19 01:38:35 kloeri Exp $

inherit distutils

DESCRIPTION="Python wrapper for libmad MP3 decoding in python"
HOMEPAGE="http://www.spacepants.org/src/pymad/"
SRC_URI="http://www.spacepants.org/src/pymad/download/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/python
	media-sound/mad"

src_compile() {
	./config_unix.py --prefix /usr || die
	distutils_src_compile
}

mydoc="AUTHORS NEWS THANKS"
