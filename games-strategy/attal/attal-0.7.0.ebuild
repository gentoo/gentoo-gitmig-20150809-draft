# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/attal/attal-0.7.0.ebuild,v 1.1 2003/09/10 05:27:31 vapier Exp $

inherit games

MY_P=${PN}-src-${PV}
DESCRIPTION="turn-based strategy game project"
HOMEPAGE="http://www.attal-thegame.org/"
SRC_URI="mirror://sourceforge/attal/${MY_P}.bz2
	mirror://sourceforge/attal/themes-${PV}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=x11-libs/qt-3*"

S=${WORKDIR}/${MY_P}

src_unpack() {
	tar -jxf ${DISTDIR}/${MY_P}.bz2 || die "unpacking src"
	tar -jxf ${DISTDIR}/themes-${PV}.bz2 || die "unpacking themes"
	cd ${S}
	qmake -o Makefile Makefile.pro || die "making Makefile"
	for lib in Client Common Fight Server ; do
		sed -i \
			-e "/^TARGET/s:= ${lib}:= ${PN}${lib}:" lib${lib}/Makefile.pro \
			-e "s:lib${lib}\.so:lib${PN}${lib}.so:g" \
			-e "s:-l${lib}:-l${PN}${lib}:g" \
			*/Makefile.pro || die "renaming ${lib}"
	done
	sed -i \
		"s:\./themes/:${GAMES_DATADIR}/${PN}/themes/:" \
		`grep -Rl '\./themes/' *` || die "fixing theme loc"
}

src_compile() {
	make || die
}

src_install() {
	exeinto ${GAMES_LIBDIR}
	doexe lib*.so.{0,1}
	dogamesbin attal-*
	newgamesbin scenario-editor attal-scenario-editor
	newgamesbin theme-editor attal-theme-editor
	dodir ${GAMES_DATADIR}/${PN}
	mv ${WORKDIR}/themes ${D}/${GAMES_DATADIR}/${PN}/
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
