# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/winesetuptk/winesetuptk-0.7.ebuild,v 1.8 2005/08/16 03:50:48 vapier Exp $

inherit eutils

MY_P1=tcltk-${P}
MY_P=${P/-/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Setup tool for WiNE adapted from Codeweavers by Debian"
HOMEPAGE="http://www.winehq.org/"
SRC_URI="mirror://sourceforge/wine/winesetuptk-0.7.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-perms.patch
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
