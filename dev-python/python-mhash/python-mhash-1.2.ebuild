# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-mhash/python-mhash-1.2.ebuild,v 1.2 2004/06/25 01:46:25 agriffis Exp $

inherit distutils

DESCRIPTION="Python interface to libmhash"
SRC_URI="mirror://sourceforge/mhash/${P}.tar.gz"
HOMEPAGE="http://mhash.sourceforge.net/"
DEPEND="virtual/python
		app-crypt/mhash"
IUSE=""
SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	# fix a glitch for gcc3.3 compiling
	sed '231s/$/\\/' -i ${S}/mhash.c
}

src_install() {
	mydoc="AUTHORS LICENSE NEWS PKG-INFO README"
	distutils_src_install
}
