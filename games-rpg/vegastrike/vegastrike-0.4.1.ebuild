# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/vegastrike/vegastrike-0.4.1.ebuild,v 1.12 2004/06/01 20:06:36 mr_bones_ Exp $

inherit flag-o-matic eutils games

DESCRIPTION="A 3D space simulator that allows you to trade and bounty hunt"
HOMEPAGE="http://vegastrike.sourceforge.net/"
SRC_URI="mirror://sourceforge/vegastrike/${P}-installer.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="virtual/x11
	virtual/glu
	virtual/glut
	virtual/opengl
	media-libs/libsdl
	media-libs/jpeg
	media-libs/libpng
	dev-libs/expat
	media-libs/openal
	media-libs/sdl-mixer
	=x11-libs/gtk+-1*"
DEPEND="${RDEPEND}
	dev-lang/perl
	>=sys-devel/autoconf-2.58"

S="${WORKDIR}/${P}-installer"

src_unpack() {
	unpack ${A}
	cd ${S}
	for tar in ${P}-{data,source,setup}.tgz ; do
		tar -zxf ${tar} || die "tar ${tar} failed"
		# save space :)
		rm ${tar}
	done
	epatch "${FILESDIR}/${PV}-endianess.patch"

	# Clean up data dir
	find data -name CVS -type d -exec rm -rf '{}' \; >&/dev/null
	find data -name '*~' -type f -exec rm -f '{}' \; >&/dev/null

	# we install this as vsinstall so fix it up here.
	mv vsfinalize vsinstall
	epatch "${FILESDIR}/${PV}-vsinstall.patch"
	sed -i \
		-e "s!/usr/local/share/vegastrike!${GAMES_DATADIR}/vegastrike!" \
		-e "s!/usr/local/bin!${GAMES_BINDIR}!" \
		vsinstall \
		|| die "sed vsinstall failed"

	# Sort out directory references
	sed -i \
		-e "s!/usr/local/share/doc!/usr/share/doc!" \
		-e "s!/usr/local/share/vegastrike!${GAMES_DATADIR}/vegastrike!" \
		-e "s!/usr/games/vegastrike!${GAMES_DATADIR}/vegastrike!" \
		-e "s!/usr/local/bin!${GAMES_BINDIR}!" \
		-e "s!/usr/local/lib/man!/usr/share/man!" \
		data/documentation/vegastrike.1 \
		|| die "sed data/documentation/vegastrike.1 failed"

	cd ${S}/vegastrike
	sed -i \
		-e "s!/usr/games/vegastrike!${GAMES_DATADIR}/vegastrike!" \
		-e "s!/usr/local/bin!${GAMES_BINDIR}!" \
		launcher/saveinterface.cpp \
		|| die "sed launcher/saveinterface.cpp failed"
	sed -i \
		"s!/usr/local/share/vegastrike!${GAMES_DATADIR}/vegastrike!" \
		src/common/common.cpp \
		|| die "sed src/common/common.cpp failed"
	sed -i \
		"s!/usr/share/local/vegastrike!${GAMES_DATADIR}/vegastrike!" \
		src/filesys.cpp \
		|| die "sed src/filesys.cpp failed"
	sed -i \
		-e '/^SUBDIRS =/s:tools::' \
		Makefile.am \
		|| die "sed Makefile.am failed"
	sed -i \
		-e 's:$(liblowlevel)::' \
		src/networking/Makefile.am \
		|| die "sed src/networking/Makefile.am failed"
	aclocal || die "aclocal failed"
	WANT_AUTOCONF=2.5 autoconf || die "autoconf failed"
	automake -a || die "automake failed"
}

src_compile() {
	append-flags -DGLX_GLXEXT_LEGACY

	cd ${S}/vegastrike
	egamesconf --enable-boost-128 || die "egamesconf failed"
	emake || die "emake failed"

	cd ${S}/vssetup/src/
	perl ./build || die "perl build failed"
}

src_install() {
	dogamesbin \
		vegastrike/src/vegastrike \
		vegastrike/launcher/vslauncher \
		vsinstall \
		|| die "dogamesbin failed"
	newgamesbin vssetup/src/bin/setup vssetup || die "newgamesbin failed"
	cp -rf vegastrike/src/networking/soundserver data/ || die "cp failed"

	doman data/documentation/*.1
	dodoc data/documentation/*.txt

	dodir "${GAMES_DATADIR}/${PN}"
	cp -r data/ "${D}/${GAMES_DATADIR}/${PN}/" || die "cp failed (data)"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "run vsinstall to setup your account"
	einfo "then run vslauncher to start Vega Strike"
}
