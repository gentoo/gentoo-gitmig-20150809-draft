# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/tcmplex-panteltje/tcmplex-panteltje-0.4.7-r1.ebuild,v 1.1 2006/06/28 13:24:51 hd_brummy Exp $

inherit eutils

DESCRIPTION="audio video multiplexer for 8 audio channels"
HOMEPAGE="http://panteltje.com/panteltje/dvd/"
SRC_URI="http://panteltje.com/panteltje/dvd/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_unpack() {

	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}_breakIfBrokenPatch.diff
}

src_compile() {

	sed -i "s:CFLAGS = -O2:CFLAGS +=:" Makefile
	emake  || die "emake failed"

}

src_install() {
	dobin tcmplex-panteltje
	dodoc CHANGES COPYRIGHT LICENSE README
}
