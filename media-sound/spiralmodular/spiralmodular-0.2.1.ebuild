# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/spiralmodular/spiralmodular-0.2.1.ebuild,v 1.12 2005/07/09 19:11:30 swegener Exp $

inherit eutils

IUSE=""

DESCRIPTION="SSM is a object oriented modular softsynth/ sequencer/ sampler."
HOMEPAGE="http://www.pawfal.org/Software/SSM/"
SRC_URI="mirror://sourceforge/spiralmodular/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=x11-libs/fltk-1.1
	media-sound/jack-audio-connection-kit
	media-libs/ladspa-sdk"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch || die
}

src_compile() {

	for file in `find . -name Makefile.in`; do
		sed -i s/CXXFLAGS=\\t@CXXFLAGS@/CXXFLAGS=\\t@CXXFLAGS@\ @FLTK_CXXFLAGS@/ $file
		sed -i s/CFLAGS\\t=\\t@CFLAGS@/CFLAGS\\t=\\t@CFLAGS@\ @FLTK_CFLAGS@/ $file
	done

	econf --enable-shared --enable-jack || die "configure failed"
	emake || die
}

src_install() {
	dodir /usr/bin /usr/lib /usr/share/man /usr/share/info
	dodoc Examples/*
	make bindir=${D}/usr/bin libdir=${D}/usr/lib mandir=${D}/usr/share/man infodir=${D}/usr/share/info datadir=${D}/usr/share install || die
}

pkg_postinst() {
	einfo
	einfo "Remember to remove any old ~/.sprialmodular files"
	einfo
}
