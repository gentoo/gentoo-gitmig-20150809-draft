# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdread/libdvdread-0.9.4-r1.ebuild,v 1.2 2005/02/05 13:53:16 luckyduck Exp $

inherit eutils

DESCRIPTION="Provides a simple foundation for reading DVD-Video images."
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${P}.tar.gz
		http://dvdauthor.sourceforge.net/patches/${P}.patch.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~amd64 ~alpha ~ia64 ~mips ~ppc64 ~ppc-macos"
IUSE="static"

DEPEND=">=media-libs/libdvdcss-1.1.1"

src_unpack() {
	cp ${DISTDIR}/${P}.patch.gz ${WORKDIR}

	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}.patch.gz
}

src_compile() {
	econf `use_enable static` || die "./configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"

	dobin src/.libs/*  # install executables
	cd ${D}usr/bin
	mv ./ifo_dump ./ifo_dump_dvdread

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
