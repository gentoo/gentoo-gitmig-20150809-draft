# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mixxx/mixxx-0.9.2.ebuild,v 1.4 2003/12/18 21:38:05 mholzer Exp $

DESCRIPTION="Digital DJ tool using QT 3.x"
HOMEPAGE="http://mixxx.sourceforge.net"
SRC_URI="mirror://sourceforge/mixxx/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="virtual/glibc
	>=x11-libs/qt-3.0.3
	media-libs/portaudio
	media-sound/mad
	media-libs/audiofile"

S=${WORKDIR}/${P}/src

src_compile() {
	qmake mixxx || die
	make || die
}

src_install() {
	dodir /usr/bin
	cp ./mixxx ${D}/usr/bin || die
	dodir /usr/share/mixxx
	cp ./config/* ${D}/usr/share/mixxx/ || die
}
