# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/goggles/goggles-0.7.4.ebuild,v 1.2 2004/09/03 00:59:00 dholm Exp $

inherit gcc

DESCRIPTION="User-friendly frontend for the Ogle DVD Player"
HOMEPAGE="http://www.fifthplanet.net/goggles.html"
SRC_URI="http://www.fifthplanet.net/files/goggles-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=x11-libs/fox-1.2
	>=media-video/ogle-0.9.2
	media-libs/libpng"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "/^export CC=/s:=.*:=\"$(gcc-getCC)\":" \
		-e "/^export CXX=/s:=.*:=\"$(gcc-getCXX)\":" \
		-e "/^export CFLAGS=/s:=.*:=\"${CFLAGS}\":" \
		-e "/^export CXXFLAGS=/s:=.*:=\"${CXXFLAGS}\":" \
		build/config.linux
}

src_compile() {
	./gb || die "build failed"
}

src_install() {
	dodir /usr/bin
	./gb install --prefix=${D}/usr || die
}
