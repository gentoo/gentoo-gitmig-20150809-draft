# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/id3lib/id3lib-3.8.3-r1.ebuild,v 1.2 2003/04/21 18:55:11 lostlogic Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Id3 library for C/C++"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://id3lib.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/glibc"

export CPPFLAGS="${CPPFLAGS} -Wno-deprecated"

src_install() {

	einstall || die "Install failed"
	dosym /usr/lib/libid3-3.8.so.3 /usr/lib/libid3-3.8.so.0.0.0
	dosym /usr/lib/libid3-3.8.so.0.0.0 /usr/lib/libid3-3.8.so.0
	
	dodoc AUTHORS COPYING ChangeLog HISTORY INSTALL README THANKS TODO
#	some example programs to be placed in docs dir.
	make clean
	cp -a examples ${D}/usr/share/doc/${PF}/examples
}
