# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdread/libdvdread-0.9.4-r1.ebuild,v 1.5 2005/07/09 01:28:59 vapier Exp $

inherit eutils

DESCRIPTION="Provides a simple foundation for reading DVD-Video images."
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${P}.tar.gz
		http://dvdauthor.sourceforge.net/patches/${P}.patch.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE="static"

DEPEND=">=media-libs/libdvdcss-1.1.1"

src_unpack() {
	cp ${DISTDIR}/${P}.patch.gz ${WORKDIR}

	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}.patch.gz
}

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
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
