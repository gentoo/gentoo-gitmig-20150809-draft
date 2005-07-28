# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qdvdauthor/qdvdauthor-0.0.9.ebuild,v 1.4 2005/07/28 11:03:28 dholm Exp $

inherit kde-functions

DESCRIPTION="QDVDAuthor, the GUI frontend for dvdauthor and other related tools."
HOMEPAGE="http://qdvdauthor.sourceforge.net/"
SRC_URI="mirror://sourceforge/qdvdauthor/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=">=media-video/dvdauthor-0.6.10
	>=media-gfx/imagemagick-5.5.7.11
	>=media-video/mjpegtools-1.6.2
	>=media-libs/xine-lib-1_rc5
	>=media-video/dvd-slideshow-0.6.0
	media-sound/sox
	media-sound/lame
	media-libs/libogg"

# xine-libs or mplayer libs or media-video/vlc - mplayer use flags?

need-qt 3.2

# >=media-video/dvd-slideshow-0.6.0 -> optional

src_compile() {

	./configure --with-xine-support || die "config fault"
	#export IMAGE_LIB="imagemagicklib" # QTDIR="$QTDIR" QT_LIB="$QT_LIB"
	# fixing defaults from /usr/local/bin to gentoo default /usr/bin
	#export VIDEO_LIB="xine"
	#export QT_LIB="$QTDIR"
	sed -i "s|/usr/local/bin|/usr/bin|g" qdvdauthor/qdvdauthor.cpp qdvdauthor/dialogexecute.cpp doc/sound.txt
	cd qdvdauthor
	${QTDIR}/bin/qmake qdvdauthor.pro

	# fixing Makefile, so that we can use our CFLAGS
	sed -i -e "s|^CFLAGS.*-O2|CFLAGS = ${CFLAGS} |g" -e "s|^CXXFLAGS.*-O2|CXXFLAGS = ${CXXFLAGS} |g" Makefile
	emake || die "emake qdvdauthor failed"

	cd qslideshow
	${QTDIR}/bin/qmake qslideshow.pro
	# fixing Makefile, so that we can use our CFLAGS
	sed -i -e "s|^CFLAGS.*-O2|CFLAGS   = ${CFLAGS} |g" -e "s|^CXXFLAGS.*-O2|CXXFLAGS = ${CXXFLAGS} |g" Makefile
	emake || die "emake qslideshow failed"
}

src_install() {
	make -C qdvdauthor INSTALL_ROOT=${D} install || die "qdvdauthor install failed"
	make -C qdvdauthor/qslideshow INSTALL_ROOT=${D} install || die "qslideshow install failed"

	#had to prevent it from trying to install dvdproject link
	dobin bin/q*
	dodoc CHANGELOG COPYING INSTALL README TODO doc/*
	insinto "/usr/share/applications"
	doins qdvdauthor.desktop
	insinto "/usr/share/pixmaps"
	doins qdvdauthor.png
}
