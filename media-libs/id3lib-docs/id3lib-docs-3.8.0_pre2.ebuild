# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/id3lib-docs/id3lib-docs-3.8.0_pre2.ebuild,v 1.8 2003/02/13 12:45:42 vapier Exp $

MY_P=${PN/-docs/}-${PV/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Id3 library for C/C++ -- API Refrence"
SRC_URI="mirror://sourceforge/id3lib/${MY_P}.tar.gz"
HOMEPAGE="http://id3lib.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc "

DEPEND="app-doc/doxygen
	media-libs/id3lib"

src_compile() {

	cd doc/
	/usr/bin/doxygen Doxyfile

}

src_install() {

	# Using ${D} here dosent seem to work. Advice?
	#dodir /usr/share/doc/${P}
	c#p -a doc/* ${D}/usr/share/doc/${P}
	dohtml -r doc

	dodoc AUTHORS COPYING ChangeLog HISTORY NEWS README THANKS TODO
}
