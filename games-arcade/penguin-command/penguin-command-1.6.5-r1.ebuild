# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/penguin-command/penguin-command-1.6.5-r1.ebuild,v 1.1 2003/09/10 19:29:21 vapier Exp $

DESCRIPTION="A clone of the classic Missile Command Game"
SRC_URI="mirror://sourceforge/penguin-command/${P}.tar.gz"
HOMEPAGE="http://www.linux-games.com/penguin-command/"

KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-libs/libpng-1.2.4
	>=media-libs/jpeg-6b
	>=media-libs/libsdl-1.2.4
	>=media-libs/sdl-mixer-1.2.4"

src_compile() {
	./configure --host=${CHOST} --prefix=/usr \
	--mandir=/usr/share/man \
	--datadir=/usr/share || die "configure failed"
	emake || die "emake failed"
}

src_install () {
	make prefix=${D}/usr \
	mandir=${D}/usr/share/man \
	datadir=${D}/usr/share install || die "make install failed"

	dodoc COPYING ChangeLog INSTALL README NEWS AUTHORS
}
