# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/tome/tome-2.2.2.ebuild,v 1.1 2003/09/10 04:59:58 vapier Exp $

inherit games

MY_PV=${PV//./}
S="${WORKDIR}/tome-${MY_PV}-src"

DESCRIPTION="A roguelike game, where you can save the world from Morgoth and battle evil (or become evil ;])"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
SRC_URI="http://t-o-m-e.net/dl/src/tome-${MY_PV}-src.tgz"
HOMEPAGE="http://t-o-m-e.net/"

RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5
	>=x11-base/xfree-4.0"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_compile() {
	cd src && \
	emake -f makefile.std \
		COPTS="${CFLAGS}" \
		BINDIR=${GAMES_BINDIR} \
		LIBDIR=${GAMES_DATADIR}/tome/lib || \
			die "emake failed"
}

src_install() {
	cd ${S}/src && \
	make -f makefile.std \
		BINDIR=${D}${GAMES_BINDIR} \
		LIBDIR=${D}${GAMES_DATADIR}/tome/lib install || \
			die "make install failed"
	cd ${S} && \
	dodoc *.txt || die "dodoc failed"

	prepgamesdirs
}

pkg_postinst() {
	echo
	ewarn "ToME ${PV} is not save-game compatible with previous versions."
	echo
	einfo "If you have older save files and you wish to continue those games,"
	einfo "you'll need to remerge the version of ToME with which you started"
	einfo "those save-games."
	echo

	games_pkg_postinst
}
