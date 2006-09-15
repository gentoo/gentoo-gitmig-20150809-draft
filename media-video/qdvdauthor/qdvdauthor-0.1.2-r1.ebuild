# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qdvdauthor/qdvdauthor-0.1.2-r1.ebuild,v 1.2 2006/09/15 14:04:27 sbriesen Exp $

inherit eutils qt3

DESCRIPTION="'Q' DVD-Author is a GUI frontend for dvdauthor written in Qt"
HOMEPAGE="http://qdvdauthor.sourceforge.net/"
SRC_URI="mirror://sourceforge/qdvdauthor/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="xine mplayer"
DEPEND=">=media-video/dvdauthor-0.6.11
	>=media-gfx/imagemagick-6.1.8.8
	>=media-video/mjpegtools-1.6.2
	>=media-video/dvd-slideshow-0.7.2
	xine? ( >=media-libs/xine-lib-1.1.0 )
	mplayer? ( media-video/mplayer )
	!xine? ( !mplayer? ( >=media-libs/xine-lib-1.1.0 ) )
	media-sound/sox
	media-sound/lame
	media-sound/toolame
	media-libs/netpbm
	$(qt_min_version 3.2)"

# TODO:
# media-video/dvd-slideshow -> optional
# installing further tools -> needs evaluation

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
	local myconf="--build-qplayer --build-qslideshow"

	# select backend (VLC is currently broken)
	#use vlc && myconf="${myconf} --with-vlc-support"
	use xine && myconf="${myconf} --with-xine-support"
	use mplayer && myconf="${myconf} --with-mplayer-support"

	# if no backend selected, use XINE as default
	if ! use xine && ! use mplayer; then
		myconf="${myconf} --with-xine-support"
	fi

	./configure --prefix=/usr ${myconf} || die "configure failed"
}

src_install() {
	make -C qdvdauthor            INSTALL_ROOT="${D}" install || die "qdvdauthor install failed"
	make -C qdvdauthor/qslideshow INSTALL_ROOT="${D}" install || die "qslideshow install failed"
	make -C qdvdauthor/qplayer    INSTALL_ROOT="${D}" install || die "qplayer install failed"

	dobin bin/{qdvdauthor,qslideshow,qplayer}
	dodoc CHANGELOG INSTALL README TODO doc/{bugs,ISO_639,render*,sound*,todo*}.txt
	domenu qdvdauthor.desktop
	doicon qdvdauthor.png
}
