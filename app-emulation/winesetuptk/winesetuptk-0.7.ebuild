# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/winesetuptk/winesetuptk-0.7.ebuild,v 1.2 2004/02/20 06:08:34 mr_bones_ Exp $

MY_P1=tcltk-${P}
MY_P=${P/-/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Setup tool for WiNE adapted from Codeweavers by Debian"
SRC_URI="mirror://sourceforge/wine/winesetuptk-0.7.tar.gz"
HOMEPAGE="http://www.winehq.org"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"

DEPEND="virtual/x11"

src_compile() {
	cd ${S}/${MY_P1}
	./build.sh

	cd ${S}/${P}

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--localstatedir=/var/lib \
		--sysconfdir=/etc/wine \
		--enable-curses \
		--with-tcltk=${S}/${MY_P1} \
		--with-launcher=/usr/bin \
		--with-exe=/usr/bin \
		--with-doc=/usr/share/doc/${P} || die "configure failed"

	make || die "make failed"
}

src_install () {
	cd ${S}/${P}
	make \
		PREFIX_LAUNCHER=${D}/usr/bin \
		PREFIX_EXE=${D}/usr/bin \
		PREFIX_DOC=${D}/usr/share/doc/${P} \
		install || die

	dodoc doc/*
}
