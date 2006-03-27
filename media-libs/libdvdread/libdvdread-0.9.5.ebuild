# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdread/libdvdread-0.9.5.ebuild,v 1.1 2006/03/27 19:34:14 flameeyes Exp $

inherit eutils

DESCRIPTION="Provides a simple foundation for reading DVD-Video images."
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${P}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 arm hppa ia64 ~mips ppc ~ppc-macos ppc64 sparc x86"
IUSE="static"

DEPEND=">=media-libs/libdvdcss-1.1.1"

src_compile() {
	use ppc-macos && myconf="--with-libdvdcss=/usr"
	econf ${myconf} `use_enable static` || die "./configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"

	dobin src/.libs/*  # install executables
	cd ${D}usr/bin
	mv ./ifo_dump ./ifo_dump_dvdread

	cd ${S}
	dodoc AUTHORS ChangeLog NEWS README TODO
}
