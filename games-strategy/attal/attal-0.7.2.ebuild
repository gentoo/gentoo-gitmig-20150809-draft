# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/attal/attal-0.7.2.ebuild,v 1.2 2004/02/20 07:38:17 mr_bones_ Exp $

inherit games

MY_P=${PN}-src-${PV}
DESCRIPTION="turn-based strategy game project"
HOMEPAGE="http://www.attal-thegame.org/"
SRC_URI="mirror://sourceforge/attal/${MY_P}.tar.bz2
	mirror://sourceforge/attal/themes-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=x11-libs/qt-3*"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	for lib in Client Common Fight Server ; do
		sed -i \
			-e "/^TARGET/s:= ${lib}:= ${PN}${lib}:" \
			-e "s:lib${lib}\.so:lib${PN}${lib}.so:g" \
			-e "s:-l${lib}:-l${PN}${lib}:g" \
			*/*.pro \
			|| die "renaming ${lib}"
	done
	qmake -o Makefile Makefile.pro || die "qmake failed"
	sed -i \
		"s:\./themes/:${GAMES_DATADIR}/${PN}/themes/:" \
		`grep -Rl '\./themes/' *` \
		|| die "fixing theme loc"
}

src_compile() {
	emake -j1 \
		CFLAGS="${CFLAGS} -fPIC" \
		CXXFLAGS="${CXXFLAGS} -fPIC" \
		|| die
}

src_install() {
	exeinto ${GAMES_LIBDIR}
	local lib=""
	local nlib=""
	for lib in lib*.so.${PV} ; do
		doexe ${lib}
		nlib=${lib/.${PV}}
		for v in ${PV//./ } ; do
			dosym ${lib} ${GAMES_LIBDIR}/${nlib}.${v}
		done
		dosym ${lib} ${GAMES_LIBDIR}/${nlib}
	done
	dogamesbin attal-*
	newgamesbin scenario-editor attal-scenario-editor
	newgamesbin theme-editor attal-theme-editor
	dodir ${GAMES_DATADIR}/${PN}
	cp -r ${WORKDIR}/themes-${PV} ${D}/${GAMES_DATADIR}/${PN}/themes
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
