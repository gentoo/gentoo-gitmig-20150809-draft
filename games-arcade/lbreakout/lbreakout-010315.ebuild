# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/lbreakout/lbreakout-010315.ebuild,v 1.2 2004/01/06 02:55:54 avenj Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Breakout clone written with the SDL library"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"
HOMEPAGE="http://lgames.sourceforge.net"
KEYWORDS="x86 ppc ~amd64"
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
