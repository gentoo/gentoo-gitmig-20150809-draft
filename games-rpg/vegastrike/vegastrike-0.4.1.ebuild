# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/vegastrike/vegastrike-0.4.1.ebuild,v 1.4 2003/12/31 06:32:54 vapier Exp $

inherit games eutils flag-o-matic

DESCRIPTION="A 3D space simulator that allows you to trade and bounty hunt"
HOMEPAGE="http://vegastrike.sourceforge.net/"
SRC_URI="mirror://sourceforge/vegastrike/${P}-installer.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="sdl"

RDEPEND="virtual/glu
	virtual/glut
	virtual/opengl
	media-libs/libsdl
	media-libs/jpeg
	media-libs/libpng
	dev-libs/expat
	media-libs/openal
	media-libs/sdl-mixer
	virtual/x11
	=x11-libs/gtk+-1*"
DEPEND="${RDEPEND}
	dev-lang/perl"

S=${WORKDIR}/${P}-installer

src_unpack() {
	unpack ${A}
	cd ${S}
	for tar in ${P}-{data,source,setup}.tgz ; do
		tar -zxf ${tar}
		# save space :)
		rm ${tar}
	done

	# Clean up data dir
	find data -name CVS -type d -exec rm -rf '{}' \; >&/dev/null
	find data -name '*~' -type f -exec rm -f '{}' \; >&/dev/null

	# Sort out directory references
	sed -i \
		-e "s!/usr/local/share/doc!/usr/share/doc!" \
		-e "s!/usr/local/share/vegastrike!${GAMES_DATADIR}/vegastrike!" \
		-e "s!/usr/games/vegastrike!${GAMES_DATADIR}/vegastrike!" \
		-e "s!/usr/local/bin!${GAMES_BINDIR}!" \
		-e "s!/usr/local/lib/man!/usr/share/man!" \
		data/documentation/vegastrike.1
	sed -i \
		-e "s!/usr/games/vegastrike!${GAMES_DATADIR}/vegastrike!" \
		-e "s!/usr/local/bin!${GAMES_BINDIR}!" \
		vegastrike/launcher/saveinterface.cpp
	sed -i \
		"s!/usr/local/share/vegastrike!${GAMES_DATADIR}/vegastrike!" \
		vegastrike/src/common/common.cpp
	sed -i \
		"s!/usr/share/local/vegastrike!${GAMES_DATADIR}/vegastrike!" \
		vegastrike/src/filesys.cpp
	sed -i \
		-e "s!/usr/local/games/vegastrike!${GAMES_DATADIR}/vegastrike!" \
		-e "s!/usr/local/bin!${GAMES_BINDIR}!" \
		vsfinalize

	cd ${S}/vegastrike
	sed -i '/^SUBDIRS =/s:tools::' Makefile.am
	sed -i 's:$(liblowlevel)::' src/networking/Makefile.am
	aclocal || die "aclocal failed"
	WANT_AUTOCONF_2_5=1 autoconf || die "autoconf failed"
	automake -a || die "automake failed"
}

src_compile() {
	append-flags -DGLX_GLXEXT_LEGACY

	cd ${S}/vegastrike
	egamesconf || die "econf failed"
	emake || die "emake failed"

	cd ${S}/vssetup/src/
	perl ./build || die "perl build failed"
}

src_install() {
	newgamesbin vsfinalize vsinstall
	newgamesbin vssetup/src/bin/setup vssetup
	dogamesbin vegastrike/src/vegastrike
	dogamesbin vegastrike/launcher/vslauncher
	cp -rf vegastrike/src/networking/soundserver data/

	doman data/documentation/*.1
	dodoc data/documentation/*.txt

	dodir ${GAMES_DATADIR}/${PN}
	cp -r data ${D}/${GAMES_DATADIR}/${PN}/

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "run vsinstall to setup your account"
	einfo "then run vslauncher to start Vega Strike"
}
