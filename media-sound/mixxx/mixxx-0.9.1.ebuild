# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mixxx/mixxx-0.9.1.ebuild,v 1.1 2002/10/14 11:32:14 verwilst Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Digital DJ tool using QT 3.x"
HOMEPAGE="http://mixxx.sourceforge.net"
SRC_URI="mirror://sourceforge/mixxx/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND="virtual/glibc 
	>=x11-libs/qt-3.0.3 
	media-libs/portaudio 
	media-sound/mad 
	media-libs/audiofile"

src_compile() {
	qmake mixxx || die
	make
}

src_install() {
	
	mkdir -p ${D}/usr/bin
	cp ./mixxx ${D}/usr/bin || die
	mkdir -p ${D}/usr/share/mixxx
	cp ./config/* ${D}/usr/share/mixxx/ || die

}
