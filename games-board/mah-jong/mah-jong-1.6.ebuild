# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/mah-jong/mah-jong-1.6.ebuild,v 1.4 2004/03/18 09:39:08 mr_bones_ Exp $

inherit games

MY_P="mj-${PV}-src"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="A networked Mah Jong program, together with a computer player"
HOMEPAGE="http://www.stevens-bradfield.com/MahJong/"
SRC_URI="http://www.stevens-bradfield.com/MahJong/Source/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="virtual/x11
	=x11-libs/gtk+-1.2*"
DEPEND="${RDEPEND}
	dev-lang/perl
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e '/^.TH/ s/1/6/' xmj.man || \
			die "sed xmj.man failed"
	sed -i \
		-e "/^DESTDIR =/ s:=.*:= ${D}:" \
		-e "/^BINDIR =/ s:=.*:= ${GAMES_BINDIR}:" \
		-e "/^MANDIR =/ s:man/man1:/usr/share/man/man6:" \
		-e "/^MANSUFFIX =/ s:1:6:" \
		-e "/^CFLAGS =/ s:=:= ${CFLAGS}:" \
		-e "/^TILESETPATH=/ s:NULL:\"${GAMES_DATADIR}/${PN}/\":" Makefile || \
			die "sed Makefile failed"
}

src_install() {
	make install install.man || die "make install failed"
	dodir ${GAMES_DATADIR}/${PN}
	cp -R fallbacktiles/ \
		tiles-numbered/ \
		tiles-small/ "${D}${GAMES_DATADIR}/${PN}" \
		|| die "cp failed"
	dodoc CHANGES ChangeLog *.txt
	prepgamesdirs
}
