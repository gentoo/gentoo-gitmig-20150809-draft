# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/wumpus/wumpus-1.4.ebuild,v 1.9 2005/05/17 18:30:42 wolf31o2 Exp $

inherit toolchain-funcs games

DESCRIPTION="Classic Hunt the Wumpus Adventure Game"
HOMEPAGE="http://cvsweb.netbsd.org/bsdweb.cgi/src/games/wump/"
SRC_URI="ftp://ftp.netbsd.org/pub/NetBSD/NetBSD-release-1-6/src/games/wump/wump.c
	ftp://ftp.netbsd.org/pub/NetBSD/NetBSD-release-1-6/src/games/wump/wump.6
	ftp://ftp.netbsd.org/pub/NetBSD/NetBSD-release-1-6/src/games/wump/wump.info"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/libc
	sys-apps/less"

S=${WORKDIR}

src_unpack() {
	for i in wump.{info,c,6} ; do
		cp ${DISTDIR}/${i} ${S}/
	done
}

src_compile() {
	touch pathnames.h
	[ -z "${PAGER}" ] && PAGER=/usr/bin/less
	$(gcc-getCC) -Dlint -D_PATH_PAGER=\"${PAGER}\" \
		-D_PATH_WUMPINFO=\"${GAMES_DATADIR}/${PN}/wump.info\" ${CFLAGS} \
		-o wump wump.c
}

src_install() {
	dogamesbin wump || die
	doman wump.6
	insinto ${GAMES_DATADIR}/${PN}
	doins wump.info
	prepgamesdirs
}
