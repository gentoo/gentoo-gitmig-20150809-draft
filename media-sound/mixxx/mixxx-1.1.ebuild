# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mixxx/mixxx-1.1.ebuild,v 1.2 2003/12/18 21:38:05 mholzer Exp $

DESCRIPTION="Digital DJ tool using QT 3.x"
HOMEPAGE="http://mixxx.sourceforge.net"
SRC_URI="mirror://sourceforge/mixxx/${P}.tar.gz"
RESTRICT="nomirror"
S="${WORKDIR}/${P}/src"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND="virtual/glibc
	>=x11-libs/qt-3.1.0
	media-sound/mad
	=dev-libs/fftw-2.1.5
	media-libs/libogg
	media-libs/libvorbis
	dev-lang/perl
	media-libs/audiofile"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	cd ${S}
	qmake mixxx.pro || die
	make || die
}

src_install() {
	cd ..
	sed -i -e "s#$BASE='/usr';#$BASE='${D}/usr';#" install.pl
	./install.pl || die

	einfo ""
	einfo "Fixing permissions..."
	einfo ""

	chmod 644 ${D}/usr/share/doc/mixxx-1.0/*
	chmod 644 ${D}/usr/share/mixxx/midi/*
	chmod 644 ${D}/usr/share/mixxx/skins/outline/*
	chmod 644 ${D}/usr/share/mixxx/skins/traditional/*
}
