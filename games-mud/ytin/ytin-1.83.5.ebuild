# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/ytin/ytin-1.83.5.ebuild,v 1.2 2004/02/20 06:45:14 mr_bones_ Exp $

inherit games

DESCRIPTION="yet another TinTin++"
HOMEPAGE="http://ytin.sourceforge.net/"
SRC_URI="mirror://sourceforge/ytin/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="sys-libs/ncurses
	>=sys-apps/sed-4"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:extern int errno;::' utils.cpp
	echo '#include <errno.h>' >> tintin.h
	sed -i '/^LIBS = /s:=:= -lstdc++ :' Makefile.in
}

src_compile() {
	econf || die
	emake CFLAGS="${CFLAGS}" || die "emake died"
}

src_install() {
	dobin tt++ || die
	dodoc ChangeLog README.1st docs/*.txt
	prepgamesdirs
}
