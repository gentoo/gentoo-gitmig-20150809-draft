# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/aterm/aterm-0.4.2-r3.ebuild,v 1.10 2003/09/07 00:24:54 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A terminal emulator with transparency support as well as rxvt backwards compatibility"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://aterm.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND="media-libs/jpeg
	media-libs/libpng
	virtual/x11"
RDEPEND=$DEPEND

src_unpack() {
	unpack ${A}
	cd ${S}/src
	cp feature.h feature.h.orig
	sed "s:\(#define LINUX_KEYS\):/\*\1\*/:" \
		feature.h.orig > feature.h
}

src_compile() {
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--enable-transparency \
		--enable-fading \
		--enable-background-image \
		--enable-menubar \
		--enable-graphics \
		--enable-utmp \
		--with-x

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	fperms g+s /usr/bin/aterm
	fowners root.utmp /usr/bin/aterm

	dodoc TODO ChangeLog INSTALL doc/BUGS doc/FAQ doc/README.menu
	docinto menu
	dodoc doc/menu/*
	dohtml -r .
}
