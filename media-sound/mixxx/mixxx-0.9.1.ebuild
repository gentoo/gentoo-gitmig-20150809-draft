# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mixxx/mixxx-0.9.1.ebuild,v 1.5 2003/09/07 00:06:06 msterret Exp $

DESCRIPTION="Digital DJ tool using QT 3.x"
HOMEPAGE="http://mixxx.sourceforge.net"
SRC_URI="mirror://sourceforge/mixxx/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="virtual/glibc
	>=x11-libs/qt-3.0.3
	media-libs/portaudio
	media-sound/mad
	media-libs/audiofile"

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
