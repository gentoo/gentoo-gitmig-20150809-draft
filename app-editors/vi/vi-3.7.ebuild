# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Spider <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/vi/vi-3.7.ebuild,v 1.2 2002/05/12 19:52:52 spider Exp $

MY_P=ex-020403
S=${WORKDIR}/${MY_P}

DESCRIPTION="The original VI package"
SRC_URI="http://download.berlios.de/ex-vi/${MY_P}.tar.gz"
HOMEPAGE="http://ex-vi.berlios.de/"
LICENSE="Caldera"
DEPEND="virtual/glibc sys-libs/ncurses"
SLOT="0"
RDEPEND=$DEPEND

src_compile() {
	make DESTDIR=/usr \
		TERMLIB=ncurses \
		PRESERVEDIR=/var/preserve || die "failed compilation"
}

src_install () {
	dodir /var/preserve
	dodir /usr/share/man
	make INSTALL=/usr/bin/install \
		DESTDIR=${D}/usr \
		MANDIR=/share/man \
		PRESERVEDIR=${D}/var/preserve \
		TERMLIB=ncurses \
		install || die
	dodoc Changes LICENSE README TODO
}
