# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/id3ed/id3ed-1.10.4.ebuild,v 1.7 2004/03/01 05:37:14 eradicator Exp $

DESCRIPTION="ID3 tag editor for mp3 files"
HOMEPAGE="http://www.azstarnet.com/~donut/programs/id3ed.html"
SRC_URI="http://www.azstarnet.com/~donut/programs/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="sys-libs/ncurses
	sys-libs/readline"

src_compile() {
	econf || die
	emake CFLAGS="${CFLAGS} -I./" || die
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	einstall || die

	dodoc README ChangeLog INSTALL
}
