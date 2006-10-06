# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/chromium/chromium-0.9.12-r6.ebuild,v 1.7 2006/10/06 22:06:36 nyhm Exp $

inherit eutils flag-o-matic qt3 toolchain-funcs versionator games

MY_PV=$(get_version_component_range -2)
DESCRIPTION="Chromium B.S.U. - an arcade game"
HOMEPAGE="http://www.reptilelabour.com/software/chromium/"
SRC_URI="http://www.reptilelabour.com/software/files/${PN}/${PN}-src-${PV}.tar.gz
	 http://www.reptilelabour.com/software/files/${PN}/${PN}-data-${PV}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="sdl qt3 vorbis"

DEPEND="virtual/opengl
	virtual/glu
	x11-libs/libXmu
	sdl? ( media-libs/libsdl
		media-libs/smpeg )
	!sdl? ( virtual/glut )
	vorbis? ( media-libs/libvorbis )
	qt3? ( $(qt_min_version 3.3) )
	media-libs/openal
	media-libs/freealut"

S=${WORKDIR}/Chromium-${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${PV}-gcc3-gentoo.patch \
		"${FILESDIR}"/${PV}-freealut.patch \
		"${FILESDIR}"/${PV}-configure.patch
	if use qt3 ; then
		epatch "${FILESDIR}/${PV}-qt3.patch"
	fi
	append-flags -DPKGDATADIR="'\"${GAMES_DATADIR}/${PN}\"'"
	append-flags -DPKGBINDIR="'\"${GAMES_BINDIR}\"'"
	sed -i \
		-e "s:-O2 -DOLD_OPENAL:${CXXFLAGS}:" src/Makefile \
			|| die "sed src/Makefile failed"
	sed -i \
		-e "s:-g:${CXXFLAGS}:" src-setup/Makefile \
			|| die "sed src-setup/Makefile failed"
	sed -i \
		-e "s:-O2:${CFLAGS}:" support/glpng/src/Makefile \
			|| die "sed support/glpng/src/Makefile failed"
	find "${S}" -type d -name CVS -exec rm -rf '{}' \; >& /dev/null
}

src_compile() {
	if use sdl ; then
		export ENABLE_SDL="yes"
		export ENABLE_SMPEG="yes"
	else
		export ENABLE_SDL="no"
		export ENABLE_SMPEG="no"
	fi
	use vorbis \
		&& export ENABLE_VORBIS="yes" \
		|| export ENABLE_VORBIS="no"
	if use qt3 ; then
		export ENABLE_SETUP="yes"
	else
		export ENABLE_SETUP="no"
	fi
	./configure || die "configure failed"
	emake -j1 \
		CC=$(tc-getCC) \
		CXX=$(tc-getCXX) \
		LINK=$(tc-getCXX) \
		|| die "emake failed"
}

src_install() {
	dogamesbin bin/chromium* || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	rm -rf data/png/.xvpics
	doins -r data || die "doins failed"
	newicon data/png/hero.png ${PN}.png
	make_desktop_entry chromium "Chromium B.S.U"
	prepgamesdirs
}
