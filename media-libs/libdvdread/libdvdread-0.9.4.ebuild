# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdread/libdvdread-0.9.4.ebuild,v 1.11 2004/08/22 03:52:22 hardave Exp $

inherit gnuconfig

DESCRIPTION="Provides a simple foundation for reading DVD-Video images."
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${P}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc hppa amd64 alpha ia64 ~mips"
IUSE=""

DEPEND=">=media-libs/libdvdcss-1.1.1"

src_compile() {
	# Needed on mips and probablly others
	gnuconfig_update

	econf || die
	make || die
}

src_install() {

	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
