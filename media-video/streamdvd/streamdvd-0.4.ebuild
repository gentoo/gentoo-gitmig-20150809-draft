# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/streamdvd/streamdvd-0.4.ebuild,v 1.4 2004/07/14 22:11:11 agriffis Exp $

DESCRIPTION="fast tool to backup Video DVDs 'on the fly'"
HOMEPAGE="http://www.badabum.de/streamdvd.html"
SRC_URI="http://www.badabum.de/down/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="media-libs/libdvdread"

S=${WORKDIR}/StreamDVD-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s: -g : ${CFLAGS} :" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin streamdvd || die
	dodoc README
}
