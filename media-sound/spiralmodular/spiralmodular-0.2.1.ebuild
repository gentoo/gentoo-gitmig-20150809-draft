# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/spiralmodular/spiralmodular-0.2.1.ebuild,v 1.3 2003/09/07 00:06:06 msterret Exp $

DESCRIPTION="SSM is a object oriented modular softsynth/ sequencer/ sampler."
HOMEPAGE="http://www.pawfal.org/Software/SSM/"
SRC_URI="mirror://sourceforge/spiralmodular/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
RDEPEND=">=x11-libs/fltk-1.1 \
	media-libs/ladspa-sdk"

DEPEND=">=x11-libs/fltk-1.1 \
	virtual/jack \
	media-libs/ladspa-sdk"

src_compile () {

	for i in `find . -name Makefile.in`
	do 	cat $i|sed s/CXXFLAGS=\\t@CXXFLAGS@/CXXFLAGS=\\t@CXXFLAGS@\ @FLTK_CXXFLAGS@/ |sed s/CFLAGS\\t=\\t@CFLAGS@/CFLAGS\\t=\\t@CFLAGS@\ @FLTK_CFLAGS@/ > $i.new
		mv $i $i.old
		mv $i.new $i
		rm $i.old
	done
        myconf="--enable-shared  --enable-jack"
	econf ${myconf} || die "configure failed"
	emake || die
}

src_install() {
	dodir /usr/bin /usr/lib /usr/share/man /usr/share/info
	dodoc Examples/*
	make bindir=${D}/usr/bin libdir=${D}/usr/lib mandir=${D}/usr/share/man infodir=${D}/usr/share/info datadir=${D}/usr/share install || die
}

pkg_postinst() {

        einfo ""
        einfo "Remember to remove any old ~/.sprialmodular files"
        einfo ""
}

