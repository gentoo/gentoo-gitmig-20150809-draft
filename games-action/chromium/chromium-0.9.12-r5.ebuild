# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/chromium/chromium-0.9.12-r5.ebuild,v 1.4 2004/03/28 09:32:41 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Chromium B.S.U. - an arcade game"
HOMEPAGE="http://www.reptilelabour.com/software/chromium/"
SRC_URI="http://www.reptilelabour.com/software/files/chromium/chromium-src-${PV}.tar.gz
	 http://www.reptilelabour.com/software/files/chromium/chromium-data-${PV}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="qt sdl oggvorbis"

DEPEND="virtual/glibc
	|| (
		sdl? ( media-libs/libsdl
			media-libs/smpeg )
		virtual/glut
	)
	oggvorbis? ( media-libs/libvorbis )
	qt? ( x11-libs/qt )
	media-libs/openal
	virtual/x11"

S=${WORKDIR}/Chromium-0.9

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc3-gentoo.patch
	epatch ${FILESDIR}/${PV}-proper-options.patch
	has_version '=x11-libs/qt-3*' && epatch ${FILESDIR}/${PV}-qt3.patch
	append-flags -DPKGDATADIR="'\"${GAMES_DATADIR}/${PN}\"'"
	append-flags -DPKGBINDIR="'\"${GAMES_BINDIR}\"'"
	sed -i "s:-O2 -DOLD_OPENAL:${CFLAGS}:" src/Makefile
	sed -i "s:-g:${CFLAGS}:" src-setup/Makefile
	sed -i "s:-O2:${CFLAGS}:" support/glpng/src/Makefile
}

src_compile() {
	if [ `use sdl` ] ; then
		export ENABLE_SDL="yes"
		export ENABLE_SMPEG="yes"
	else
		export ENABLE_SDL="no"
		export ENABLE_SMPEG="no"
	fi
	use oggvorbis \
		&& export ENABLE_VORBIS="yes" \
		|| export ENABLE_VORBIS="no"
	if use qt ; then
		export ENABLE_SETUP="yes"
		has_version '=x11-libs/qt-3*' \
			&& export QTDIR=/usr/qt/3 \
			|| export QTDIR=/usr/qt/2
	else
		export ENABLE_SETUP="no"
	fi
	./configure || die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	exeinto ${GAMES_BINDIR}
	doexe bin/chromium*

	dodir ${GAMES_DATADIR}/${PN}
	cp -r data ${D}/${GAMES_DATADIR}/${PN}/

	find ${D} -name CVS -exec rm -rf '{}' \; >& /dev/null

	prepgamesdirs
}
