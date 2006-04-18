# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/chromium/chromium-0.9.12-r5.ebuild,v 1.15 2006/04/18 12:14:57 weeve Exp $

inherit flag-o-matic eutils games

DESCRIPTION="Chromium B.S.U. - an arcade game"
HOMEPAGE="http://www.reptilelabour.com/software/chromium/"
SRC_URI="http://www.reptilelabour.com/software/files/chromium/chromium-src-${PV}.tar.gz
	 http://www.reptilelabour.com/software/files/chromium/chromium-data-${PV}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="vorbis qt sdl"

DEPEND="|| ( x11-libs/libXext virtual/x11 )
	|| (
		sdl? ( media-libs/libsdl
			media-libs/smpeg )
		virtual/glut
	)
	vorbis? ( media-libs/libvorbis )
	qt? ( =x11-libs/qt-3* )
	media-libs/openal"

S=${WORKDIR}/Chromium-0.9

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp data/png/hero.png "${T}/chromium.png" || die "cp failed"
	epatch \
		"${FILESDIR}"/${PV}-gcc3-gentoo.patch \
		"${FILESDIR}"/${PV}-proper-options.patch
	if use qt ; then
		epatch "${FILESDIR}/${PV}-qt3.patch"
	fi
	append-flags -DPKGDATADIR="'\"${GAMES_DATADIR}/${PN}\"'"
	append-flags -DPKGBINDIR="'\"${GAMES_BINDIR}\"'"
	sed -i \
		-e "s:-O2 -DOLD_OPENAL:${CFLAGS}:" src/Makefile \
			|| die "sed src/Makefile failed"
	sed -i \
		-e "s:-g:${CFLAGS}:" src-setup/Makefile \
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
	if use qt ; then
		export ENABLE_SETUP="yes"
		export QTDIR=/usr/qt/3
	else
		export ENABLE_SETUP="no"
	fi
	./configure || die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	dogamesbin bin/chromium* || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data || die "doins failed"
	doicon "${T}"/chromium.png
	make_desktop_entry chromium "Chromium B.S.U"
	prepgamesdirs
}
