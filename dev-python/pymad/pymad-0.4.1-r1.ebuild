# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymad/pymad-0.4.1-r1.ebuild,v 1.1 2003/07/18 01:13:40 raker Exp $

IUSE=""

inherit distutils

DESCRIPTION="Python wrapper for libmad MP3 decoding in python"
HOMEPAGE="http://www.spacepants.org/src/pymad/"
SRC_URI="http://www.spacepants.org/src/pymad/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/python
	media-libs/libmad
	media-libs/libid3tag"

src_compile() {
	./config_unix.py --prefix /usr || die
	distutils_src_compile
}

mydoc="AUTHORS NEWS THANKS"
