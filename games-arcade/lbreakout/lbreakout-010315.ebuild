# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/lbreakout/lbreakout-010315.ebuild,v 1.1 2003/09/10 19:29:21 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Breakout clone written with the SDL library"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"
HOMEPAGE="http://lgames.sourceforge.net"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-libs/libsdl-1.1.5"

src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die
	make || die
}

src_install() {
	dodir /var/lib/games
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING README TODO ChangeLog
	insinto /usr/share/doc/lbreakout/html
	doins lbreakout/manual/*
}
