# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/transcend/transcend-0.3.ebuild,v 1.1 2005/09/04 02:27:07 mr_bones_ Exp $

inherit games

DESCRIPTION="retro-style, abstract, 2D shooter"
HOMEPAGE="http://transcend.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/Transcend_${PV}_UnixSource.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="virtual/x11
	virtual/opengl
	virtual/glu
	virtual/glut"

S=${WORKDIR}/Transcend_${PV}_UnixSource/Transcend

src_unpack() {
	unpack ${A}
	cd "${S}"
	chmod a+x portaudio/configure
	rm -f game/Makefile
	cat \
		Makefile.GnuLinuxX86 \
		Makefile.common \
		Makefile.minorGems \
		game/Makefile.all \
		Makefile.minorGems_targets \
		> game/Makefile
	sed -i \
		-e "s:\"levels\":\"${GAMES_DATADIR}/${PN}/levels\":" \
		game/LevelDirectoryManager.cpp \
		game/game.cpp \
		|| die "sed failed"
}

src_compile() {
	cd portaudio
	egamesconf || die
	emake
	cd ../game
	emake || die
	cd ..
	cp game/Transcend ${PN} || die "cp failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r levels/ || die "doins failed"
	dodoc doc/how_to_*.txt
	prepgamesdirs
}
