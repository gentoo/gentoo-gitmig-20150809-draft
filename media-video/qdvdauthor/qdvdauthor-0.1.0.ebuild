# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qdvdauthor/qdvdauthor-0.1.0.ebuild,v 1.1 2006/01/11 02:29:50 sbriesen Exp $

inherit eutils qt3

DESCRIPTION="'Q' DVD-Author is a GUI frontend for dvdauthor written in Qt."
HOMEPAGE="http://qdvdauthor.sourceforge.net/"
SRC_URI="mirror://sourceforge/qdvdauthor/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=">=media-video/dvdauthor-0.6.11
	>=media-gfx/imagemagick-6.1.8.8
	>=media-video/mjpegtools-1.6.2
	>=media-libs/xine-lib-1.1.0
	>=media-video/dvd-slideshow-0.7.2
	media-sound/sox
	media-sound/lame
	media-libs/libogg
	$(qt_min_version 3.2)"

# TODO:
# xine-libs or mplayer or vlc-lib -> use flags
# media-video/dvd-slideshow -> optional

src_unpack() {
	unpack ${A}
	cd "${S}"

	# set our C(XX)FLAGS
	for PRO in qdvdauthor/*.pro qdvdauthor/*/*.pro; do
		echo "QMAKE_CFLAGS_RELEASE = ${CFLAGS}" >> ${PRO}
		echo "QMAKE_CXXFLAGS_RELEASE = ${CXXFLAGS}" >> ${PRO}
	done

	# full-qualify qmake in configure
	sed -i -e "s:make;:make ${MAKEOPTS};:g" \
		-e "s:qmake:\${QTDIR}/bin/qmake QMAKE=\${QTDIR}/bin/qmake:g" configure

	# fixing defaults from /usr/local/bin to gentoo default /usr/bin
	sed -i "s:/usr/local/bin:/usr/bin:g" qdvdauthor/qdvdauthor.cpp \
		qdvdauthor/dialog*.cpp qdvdauthor/qslideshow/dialog*.cpp doc/sound.txt
}

src_compile() {
	./configure --prefix=/usr --with-xine-support --build-qplayer --build-qslideshow || die "configure failed"
}

src_install() {
	make -C qdvdauthor            INSTALL_ROOT="${D}" install || die "qdvdauthor install failed"
	make -C qdvdauthor/qslideshow INSTALL_ROOT="${D}" install || die "qslideshow install failed"
	make -C qdvdauthor/qplayer    INSTALL_ROOT="${D}" install || die "qplayer install failed"

	dobin bin/q*
	dodoc CHANGELOG INSTALL README TODO doc/*.{txt,sh}
	domenu qdvdauthor.desktop
	doicon qdvdauthor.png
}
