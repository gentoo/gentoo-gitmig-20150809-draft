# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/id3ed/id3ed-1.10.4.ebuild,v 1.5 2003/03/24 18:28:12 vladimir Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="id3ed is an ID3 tag editor for mp3 files. You can set tags interactively or from the command line, or a combination of both. id3ed can set genre by name or number. You can also remove or view tags."
HOMEPAGE="http://www.azstarnet.com/~donut/programs/id3ed.html"
SRC_URI="http://www.azstarnet.com/~donut/programs/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
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
