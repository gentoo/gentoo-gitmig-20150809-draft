# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/winesetuptk/winesetuptk-0.6.0b-r3.ebuild,v 1.11 2004/07/14 01:08:35 agriffis Exp $

MY_P1=tcltk-${P}
MY_P=${P/-/_}-1.1

DESCRIPTION="Setup tool for WiNE adapted from Codeweavers by Debian"
HOMEPAGE="http://packages.debian.org/unstable/otherosfs/winesetuptk.html"
SRC_URI="mirror://debian/pool/main/w/winesetuptk/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

DEPEND="virtual/x11"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}

	tar zxf ${MY_P1}.tar.gz || die
	tar zxf ${P}.tar.gz || die
}

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

src_install() {
	cd ${S}/${P}
	make \
		PREFIX_LAUNCHER=${D}/usr/bin \
		PREFIX_EXE=${D}/usr/bin \
		PREFIX_DOC=${D}/usr/share/doc/${P} \
		install || die

	dodoc doc/*
}
