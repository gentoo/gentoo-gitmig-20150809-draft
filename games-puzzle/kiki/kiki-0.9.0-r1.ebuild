# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/kiki/kiki-0.9.0-r1.ebuild,v 1.3 2004/11/22 12:37:09 josejx Exp $

inherit python games

DATA="${GAMES_DATADIR}/${PN}"
S="${WORKDIR}"
DESCRIPTION="Fun 3D puzzle game using SDL/OpenGL"
HOMEPAGE="http://kiki.sourceforge.net/"
SRC_URI="mirror://sourceforge/kiki/${PN}-src-${PV}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2
		>=media-libs/sdl-image-1.2.2
		>=media-libs/sdl-mixer-1.2.5
		>=dev-lang/python-2.2
		virtual/glut"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-3
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	cd ${S}
	# There are CVS directories in the tgz file
	rm -rf $(find -name CVS -type d)
	rm -rf $(find -name .cvsignore)
	chmod a-x kiki_src/kiki/sounds/*.*

	# Change the hard-coded data dir for sounds, etc...
	sed -i \
		-e "s:kiki_home += \"/\";:kiki_home = \"${DATA}/\";:g" \
		-e "s:KConsole\:\:printf(\"WARNING \:\: environment variable KIKI_HOME not set ...\");::g" \
		-e "s:KConsole\:\:printf(\"           ... assuming resources in current directory\");::g" \
		kiki_src/kiki/src/main/KikiController.cpp \
		|| die "sed KikiController.cpp failed"
	sed -i \
		-e 's/import random/import random, types/' \
		kiki_src/kiki/py/world.py \
		|| die "sed world.py failed"
	python_version
	sed -i \
		-e "/^PYTHON_VERSION/s/2.2/${PYVER}/" \
		-e '/lib-dynload/d' \
		-e '/^PYTHONLIBS/s:\\:-lpython$(PYTHON_VERSION):' \
		kiki_src/kiki/linux/Makefile \
		|| die "sed kiki_src/kiki/linux/Makefile failed"
}


src_compile() {
	cd "${S}/kiki_src/kodilib/linux"
	emake || die "emake in kodilib/linux failed"
	cd "${S}/kiki_src/kiki/linux"
	emake || die "emake in kiki/linux failed"
}

src_install() {
	dogamesbin kiki_src/kiki/linux/kiki || die "dogamesbin failed"

	dodir "${DATA}/misc" "${DATA}/py" "${DATA}/sounds"
	cp -R "${S}/kiki_src/kiki/"{misc,py,sounds} "${D}${DATA}" \
		|| die "cp failed"

	cd "${S}/kiki_src/kiki"
	dodoc Readme.txt Thanks.txt "uDevGame Readme.txt"
	prepgamesdirs
}
