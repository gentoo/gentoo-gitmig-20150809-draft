# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dosbox/dosbox-0.57.ebuild,v 1.1 2003/09/09 16:26:49 vapier Exp $

DESCRIPTION="DOSBox - DOS emulator"
HOMEPAGE="http://dosbox.zophar.net"
SRC_URI="mirror://sourceforge/dosbox/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="sys-libs/ncurses
	>=media-libs/libsdl-1.2.0
	sys-libs/zlib"
S=${WORKDIR}/${P}

src_compile() {
	econf
	emake || die
}

src_install() {
	#make DESTDIR=${D} install || die
	einstall
	dodoc AUTHORS COPYING ChangeLog INSTALL NEW README THANKS
}
