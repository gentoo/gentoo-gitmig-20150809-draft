# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/ytin/ytin-1.83.5-r1.ebuild,v 1.7 2006/11/23 23:58:52 nyhm Exp $

inherit toolchain-funcs games

DESCRIPTION="yet another TinTin++"
HOMEPAGE="http://ytin.sourceforge.net/"
SRC_URI="mirror://sourceforge/ytin/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:extern int errno;::' utils.cpp \
			|| die "sed utils.cpp failed"
	echo '#include <errno.h>' >> tintin.h
	sed -i \
		-e '/^LIBS = /s:=:= -lstdc++ :' Makefile.in \
			|| die "sed Makefile.in failed"
}

src_compile() {
	egamesconf || die
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dogamesbin tt++ || die "dogamesbin failed"
	dodoc ChangeLog README.1st docs/*.txt
	prepgamesdirs
}
