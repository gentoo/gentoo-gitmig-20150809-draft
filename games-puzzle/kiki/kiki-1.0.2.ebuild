# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/kiki/kiki-1.0.2.ebuild,v 1.1 2006/03/16 20:45:25 tupone Exp $

inherit eutils python games

DESCRIPTION="Fun 3D puzzle game using SDL/OpenGL"
HOMEPAGE="http://kiki.sourceforge.net/"
SRC_URI="mirror://sourceforge/kiki/${P}-src.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2
		>=media-libs/sdl-image-1.2.2
		>=media-libs/sdl-mixer-1.2.5
		>=dev-lang/python-2.2
		virtual/glut"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	cd "${S}"
	# There are CVS directories in the tgz file
	rm -rf $(find -name CVS -type d)
	rm -rf $(find -name .cvsignore)
	rm *.dll Readme.rtf uDevGame\ Readme.txt
	edos2unix Readme.txt Thanks.txt Thanks.txt
	chmod a-x sound/*.*

	# Change the hard-coded data dir for sounds, etc...
	sed -i \
		-e "s:kiki_home += \"/\";:kiki_home = \"${GAMES_DATADIR}/${PN}/\";:g" \
		-e "s:KConsole\:\:printf(\"WARNING \:\: environment variable KIKI_HOME not set ...\");::g" \
		-e "s:KConsole\:\:printf(\"           ... assuming resources in current directory\");::g" \
		src/main/KikiController.cpp \
		|| die "sed KikiController.cpp failed"
	python_version
	sed -i \
		-e "/^PYTHON_VERSION/s/2.3/${PYVER}/" \
		-e '/lib-dynload/d' \
		-e '/^PYTHONLIBS/s:\\:-lpython$(PYTHON_VERSION):' \
		linux/Makefile \
		|| die "sed kiki_src/kiki/linux/Makefile failed"
}


src_compile() {
	cd kodilib/linux
	emake || die "emake in kodilib/linux failed"
	cd ../../linux
	emake || die "emake in linux failed"
}

src_install() {
	dogamesbin linux/kiki || die "dogamesbin failed"

	dodir "${GAMES_DATADIR}/${PN}"/{py,sound}
	cp -R py sound "${D}${GAMES_DATADIR}/${PN}" \
		|| die "cp failed"

	dodoc Readme.txt Thanks.txt
	prepgamesdirs
}
