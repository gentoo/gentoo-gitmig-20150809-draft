# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdread/libdvdread-0.9.3.ebuild,v 1.11 2004/07/14 20:05:06 agriffis Exp $

DESCRIPTION="Provides a simple foundation for reading DVD-Video images."
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/libdvdread-${PV}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "
IUSE=""

DEPEND=">=media-libs/libdvdcss-1.1.1"

src_compile() {

	econf || die
	make || die
}

src_install() {

	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
