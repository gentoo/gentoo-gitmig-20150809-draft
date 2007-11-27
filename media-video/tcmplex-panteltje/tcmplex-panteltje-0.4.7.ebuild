# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/tcmplex-panteltje/tcmplex-panteltje-0.4.7.ebuild,v 1.4 2007/11/27 11:39:43 zzam Exp $

inherit eutils

DESCRIPTION="audio video multiplexer for 8 audio channels"
HOMEPAGE="http://panteltje.com/panteltje/dvd/"
SRC_URI="http://panteltje.com/panteltje/dvd/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_compile() {

	sed -i "s:CFLAGS = -O2:CFLAGS +=:" Makefile
	emake  || die "emake failed"

}

src_install() {
	dobin tcmplex-panteltje
	dodoc CHANGES COPYRIGHT README
}
