# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/moria/moria-5.5.2.ebuild,v 1.8 2004/10/31 05:16:46 vapier Exp $

inherit eutils gcc games

DESCRIPTION="Rogue-like D&D curses game similar to nethack (BUT BETTER)"
HOMEPAGE="http://remarque.org/~grabiner/moria.html"
SRC_URI="ftp://ftp.greyhelm.com/pub/Games/Moria/source/um${PV}.tar.Z
	http://www.funet.fi/pub/unix/games/moria/source/um${PV}.tar.Z
	http://www.piratehaven.org/~beej/moria/mirror/Games/Moria/source/um${PV}.tar.Z
	http://alge.anart.no/ftp/pub/games/RPG/moria/um${PV}.tar.Z
	ftp://kane.evendata.net/pub/${PN}-extras.tar.bz2"

LICENSE="Moria"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="virtual/libc
	>=sys-libs/ncurses-5"

S="${WORKDIR}/umoria"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-gentoo-paths.patch
	epatch ${FILESDIR}/${PV}-glibc.patch

	for f in source/* unix/* ; do
		ln -s ${f} $(basename ${f})
	done

	sed -i \
		-e "s:David Grabiner:root:" \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" \
		-e "s:GENTOO_STATEDIR:${GAMES_STATEDIR}:" \
		config.h \
			|| die "sed config.h failed"
	sed -i \
		-e "/^STATEDIR =/s:=.*:=\$(DESTDIR)${GAMES_STATEDIR}:" \
		-e "/^BINDIR = /s:=.*:=\$(DESTDIR)${GAMES_BINDIR}:" \
		-e "/^LIBDIR = /s:=.*:=\$(DESTDIR)${GAMES_DATADIR}/${PN}:" \
		-e "/^CFLAGS = /s:=.*:=${CFLAGS}:" \
		-e "/^OWNER = /s:=.*:=${GAMES_USER}:" \
		-e "/^GROUP = /s:=.*:=${GAMES_GROUP}:" \
		-e "/^CC = /s:=.*:=$(gcc-getCC):" \
		Makefile \
			|| die "sed Makefile failed"
}

src_install() {
	dodir "${GAMES_BINDIR}" "${GAMES_DATADIR}/${PN}" "${GAMES_STATEDIR}"
	make DESTDIR="${D}" install || die "make install failed"

	doman doc/moria.6
	rm doc/moria.6
	dodoc README doc/* ${WORKDIR}/${PN}-extras/*

	prepgamesdirs
	fperms g+w ${GAMES_STATEDIR}/moriascores
}
