# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/aterm/aterm-0.4.2.ebuild,v 1.8 2002/07/22 13:27:39 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A terminal emulator with transparency support as well as rxvt backwards compatability"
SRC_URI="http://prdownloads.sf.net/aterm/${P}.tar.gz"
HOMEPAGE="http://aterm.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=media-libs/jpeg-6b-r2 >=media-libs/libpng-1.0.11 virtual/x11"
RDEPEND=$DEPEND

src_compile() {
	./configure --prefix=/usr --host=${CHOST} \
		--enable-transparency \
		--enable-fading \
		--enable-background-image \
		--enable-menubar \
		--enable-graphics \
		--enable-utmp \
		--disable-backspace-key \
		--with-x

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc TODO ChangeLog INSTALL doc/BUGS doc/FAQ doc/README.menu
	docinto menu
	dodoc doc/menu/*
	docinto html
	dodoc *.html
}
