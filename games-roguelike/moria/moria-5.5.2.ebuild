# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/moria/moria-5.5.2.ebuild,v 1.1 2003/12/31 20:28:17 vapier Exp $

inherit games eutils gcc

DESCRIPTION="Rogue-like D&D curses game similar to nethack (BUT BETTER)"
HOMEPAGE="http://remarque.org/~grabiner/moria.html"
SRC_URI="ftp://ftp.greyhelm.com/pub/Games/Moria/source/um${PV}.tar.Z
	http://www.funet.fi/pub/unix/games/moria/source/um${PV}.tar.Z
	http://www.piratehaven.org/~beej/moria/mirror/Games/Moria/source/um${PV}.tar.Z
	http://alge.anart.no/ftp/pub/games/RPG/moria/um${PV}.tar.Z
	ftp://kane.evendata.net/pub/${PN}-extras.tar.bz2"

LICENSE="Moria"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	>=sys-apps/sed-4
	>=sys-libs/ncurses-5"

S=${WORKDIR}/umoria

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
		config.h
	sed -i \
		-e "/^STATEDIR =/s:=.*:=\$(DESTDIR)${GAMES_STATEDIR}:" \
		-e "/^BINDIR = /s:=.*:=\$(DESTDIR)${GAMES_BINDIR}:" \
		-e "/^LIBDIR = /s:=.*:=\$(DESTDIR)${GAMES_DATADIR}/${PN}:" \
		-e "/^CFLAGS = /s:=.*:=${CFLAGS}:" \
		-e "/^OWNER = /s:=.*:=${GAMES_USER}:" \
		-e "/^GROUP = /s:=.*:=${GAMES_GROUP}:" \
		-e "/^CC = /s:=.*:=$(gcc-getCC):" \
		Makefile
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	dodir ${GAMES_BINDIR} ${GAMES_DATADIR}/${PN} ${GAMES_STATEDIR}
	make install DESTDIR=${D} || die

	doman doc/moria.6
	rm doc/moria.6
	dodoc README doc/* ${WORKDIR}/${PN}-extras/*

	prepgamesdirs
	fperms g+w ${GAMES_STATEDIR}/moriascores
}
