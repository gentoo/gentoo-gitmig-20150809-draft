# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/skstream/skstream-0.3.6.ebuild,v 1.8 2009/06/05 09:26:31 tupone Exp $
EAPI=2

inherit eutils

DESCRIPTION="FreeSockets - Portable C++ classes for IP (sockets) applications"
SRC_URI="mirror://sourceforge/worldforge/${P}.tar.bz2"
HOMEPAGE="http://www.worldforge.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

src_prepare() {
	edos2unix ping/ping.cpp
	epatch "${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-glibc2101.patch \
		"${FILESDIR}"/${P}-test.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install died"
	dodoc AUTHORS ChangeLog NEWS README README.FreeSockets TODO
}
