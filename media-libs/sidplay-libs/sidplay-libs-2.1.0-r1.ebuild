# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sidplay-libs/sidplay-libs-2.1.0-r1.ebuild,v 1.5 2004/07/01 08:03:44 eradicator Exp $

inherit libtool

DESCRIPTION="C64 SID player library"
HOMEPAGE="http://sidplay2.sourceforge.net/"
SRC_URI="mirror://sourceforge/sidplay2/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	elibtoolize
}

#src_compile() {
#	econf || die
#	emake CFLAGS="${CFLAGS} -L${D}/usr/lib" || die
#}

src_install () {
	make DESTDIR=${D} install || die
}
