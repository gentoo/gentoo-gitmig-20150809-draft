# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3kult/mp3kult-0.7-r1.ebuild,v 1.5 2004/04/01 07:44:03 eradicator Exp $

DESCRIPTION="Mp3Kult organizes your mp3/ogg collection in a Mysql database."
HOMEPAGE="http://mp3kult.sourceforge.net"
SRC_URI="mirror://sourceforge/mp3kult/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=dev-db/mysql-3.22.32
	>=media-libs/id3lib-3.7.13
	>=media-libs/libogg-1.0
	>=media-libs/libvorbis-1.0"

src_compile() {
	export CXXFLAGS="${CXXFLAGS} -DUSE_OLD_FUNCTIONS=1"
	# For whatever reason defining USE_OLD_FUNCTIONS causes
	# link errors for ssl; the next line fixes it.
	export LDFLAGS="-lssl"
	econf || die
	emake || die
}

src_install () {
	einstall || die
	dodoc ABOUT-NLS AUTHORS COPYING INSTALL MANUAL NEWS README
}
