# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/kiki/kiki-1.0.2-r2.ebuild,v 1.2 2008/05/13 16:07:10 mr_bones_ Exp $

inherit eutils python toolchain-funcs games

DESCRIPTION="Fun 3D puzzle game using SDL/OpenGL"
HOMEPAGE="http://kiki.sourceforge.net/"
SRC_URI="mirror://sourceforge/kiki/${P}-src.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.5
	>=dev-lang/python-2.2
	virtual/glut"
DEPEND="${RDEPEND}
	dev-lang/swig"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}/${P}"-gcc41.patch \
		"${FILESDIR}/${P}"-freeglut.patch
	# There are CVS directories in the tgz file
	rm -rf $(find -name CVS -type d)
	rm -rf $(find -name .cvsignore)

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

	# Bug 139570
	cd SWIG
	swig -c++ -python -globals kiki -o KikiPy_wrap.cpp KikiPy.i || die
	cp -f kiki.py ../py
}

src_compile() {
	tc-export AR CXX
	emake -C kodilib/linux || die "emake in kodilib/linux failed"
	emake -C linux || die "emake in linux failed"
}

src_install() {
	dogamesbin linux/kiki || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r py sound || die "doins failed"

	dodoc Readme.txt Thanks.txt
	prepgamesdirs
}
