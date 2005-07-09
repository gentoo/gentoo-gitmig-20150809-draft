# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdread/libdvdread-0.9.4.ebuild,v 1.19 2005/07/09 01:28:59 vapier Exp $

inherit gnuconfig

DESCRIPTION="Provides a simple foundation for reading DVD-Video images."
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${P}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc-macos ppc64 sparc x86"
IUSE=""

DEPEND=">=media-libs/libdvdcss-1.1.1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	gnuconfig_update
}

src_compile() {
	use ppc-macos && myconf="--with-libdvdcss=/usr"
	econf ${myconf} || die
	emake -j1 || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
