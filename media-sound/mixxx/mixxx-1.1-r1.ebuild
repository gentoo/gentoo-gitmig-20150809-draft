# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mixxx/mixxx-1.1-r1.ebuild,v 1.1 2003/12/29 16:39:07 wmertens Exp $

DESCRIPTION="Digital DJ tool using QT 3.x"
HOMEPAGE="http://mixxx.sourceforge.net"
SRC_URI="mirror://sourceforge/mixxx/${P}.tar.gz"
RESTRICT="nomirror"

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

src_compile() {
	cd ${S}/src
	qmake mixxx.pro || die
	sed -i -e "s/CFLAGS *= -pipe -w -O2/CFLAGS   = ${CFLAGS} -w/" Makefile
	sed -i -e "s/CXXFLAGS *= -pipe -w -O2/CXXFLAGS   = ${CXXFLAGS} -w/" Makefile
	make || die
}

src_install() {
	cd ${S}
	sed -i -e "s#$BASE='/usr';#$BASE='${D}/usr';#" install.pl
	./install.pl || die

	einfo ""
	einfo "Fixing permissions..."
	einfo ""

	chmod 644 ${D}/usr/share/doc/${PF}/*
	chmod 644 ${D}/usr/share/mixxx/midi/*
	chmod 644 ${D}/usr/share/mixxx/skins/outline/*
	chmod 644 ${D}/usr/share/mixxx/skins/outlineClose/*
	chmod 644 ${D}/usr/share/mixxx/skins/traditional/*
}
