# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/id3lib-docs/id3lib-docs-3.8.0_pre2.ebuild,v 1.14 2004/08/07 23:20:47 slarti Exp $

MY_P=${PN/-docs/}-${PV/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Id3 library for C++ -- API Reference"
HOMEPAGE="http://id3lib.sourceforge.net/"
SRC_URI="mirror://sourceforge/id3lib/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

LICENSE="LGPL-2"
DEPEND="app-doc/doxygen
	media-libs/id3lib"

src_compile() {
	cd doc/
	doxygen Doxyfile || die
}

src_install() {
	# Using ${D} here dosent seem to work. Advice?
	#dodir /usr/share/doc/${P}
	#cp -a doc/* ${D}/usr/share/doc/${P}
	dohtml -r doc
	dodoc AUTHORS COPYING ChangeLog HISTORY NEWS README THANKS TODO
}
