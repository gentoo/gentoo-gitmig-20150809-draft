# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/skstream/skstream-0.3.6.ebuild,v 1.5 2009/01/23 16:18:46 tupone Exp $

inherit eutils

DESCRIPTION="FreeSockets - Portable C++ classes for IP (sockets) applications"
SRC_URI="mirror://sourceforge/worldforge/${P}.tar.bz2"
HOMEPAGE="http://www.worldforge.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~sparc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	edos2unix ping/ping.cpp
	epatch "${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-test.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install died"
	dodoc AUTHORS ChangeLog NEWS README README.FreeSockets TODO
}
