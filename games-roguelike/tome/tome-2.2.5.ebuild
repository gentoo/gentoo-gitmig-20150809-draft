# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/tome/tome-2.2.5.ebuild,v 1.4 2004/02/20 06:55:42 mr_bones_ Exp $

inherit games

MY_PV=${PV//./}
DESCRIPTION="save the world from Morgoth and battle evil (or become evil ;])"
HOMEPAGE="http://t-o-m-e.net/"
SRC_URI="http://t-o-m-e.net/dl/src/tome-${MY_PV}-src.tgz"

LICENSE="Moria"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5
	virtual/x11"

S=${WORKDIR}/tome-${MY_PV}-src

src_unpack() {
	unpack ${A}
	cd ${S}/src
	mv makefile.std makefile
}

src_compile() {
	cd src
	emake -j1 \
		COPTS="${CFLAGS}" \
		BINDIR=${GAMES_BINDIR} \
		LIBDIR=${GAMES_DATADIR}/${PN} \
		|| die "emake failed"
}

src_install() {
	cd src
	emake -j1 \
		OWNER=${GAMES_USER} \
		BINDIR=${D}/${GAMES_BINDIR} \
		LIBDIR=${D}/${GAMES_DATADIR}/${PN} install \
		|| die "make install failed"
	cd ${S}
	dodoc *.txt

	prepgamesdirs
	touch ${D}/${GAMES_DATADIR}/${PN}/apex/scores.raw
	fperms g+w ${GAMES_DATADIR}/${PN}/apex/scores.raw
	fperms g+w ${GAMES_DATADIR}/${PN}/data
}

pkg_postinst() {
	games_pkg_postinst
	echo
	ewarn "ToME ${PV} is not save-game compatible with previous versions."
	echo
	einfo "If you have older save files and you wish to continue those games,"
	einfo "you'll need to remerge the version of ToME with which you started"
	einfo "those save-games."
}
