# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/vegastrike/vegastrike-0.3.1.ebuild,v 1.1 2003/09/10 06:26:50 vapier Exp $

inherit games eutils flag-o-matic

DATA_VER=0.3-1
DESCRIPTION="3d OpenGL Action RPG space sim"
HOMEPAGE="http://vegastrike.sourceforge.net/"
SRC_URI="mirror://sourceforge/vegastrike/${P}-gcc3.2.src.rpm
	mirror://sourceforge/vegastrike/${PN}-data-${DATA_VER}.noarch.rpm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="sdl" # openal"

RDEPEND="media-libs/glut
	virtual/x11
	sdl? ( media-libs/libsdl
		media-libs/sdl-mixer )
	media-libs/openal"
#	openal? ( media-libs/openal )"
DEPEND="${RDEPEND}
	dev-lang/perl
	app-arch/rpm2targz"

S=${WORKDIR}/${PN}

src_unpack() {
	rpm2targz ${DISTDIR}/${P}-gcc3.2.src.rpm || die "src rpm2targz failed"
	tar -zxf ${P}-gcc3.2.src.tar.gz || die "src tar 1 failed"
	tar -zxf ${PN}.tar.gz || die "src tar 2 failed"

	rpm2targz ${DISTDIR}/${PN}-data-${DATA_VER}.noarch.rpm || die "data rpm2targz failed"
	tar -zxf ${PN}-data-${DATA_VER}.noarch.tar.gz || die "src tar failed"

	cd ${S}
	autoconf || die
	automake || die

	cd ${WORKDIR}
	mv usr/local data
	cd data/bin/
	epatch ${FILESDIR}/${PV}-vsinstall.patch
}

src_compile() {
	append-flags -DGL_GLEXT_LEGACY

	local sdlconf
	use sdl \
		&& sdlconf="--enable-sdl --disable-nosdl" \
		|| sdlconf="--disable-sdl --enable-nosdl"
	egamesconf ${sdlconf} || die

	cp src/common/{common.cpp,common.cpp.orig}
	sed -e "s:/opt/share/vegastrike/data:${GAMES_DATADIR}/${PN}/data:" \
		src/common/common.cpp.orig > src/common/common.cpp
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dogamesbin ${WORKDIR}/data/bin/vsinstall vssetup vslauncher

	dodoc NEWS AUTHORS README ChangeLog ${WORKDIR}/data/doc/vegastrike/readme.txt
	doman ${WORKDIR}/data/man/man1/*

	dodir ${GAMES_DATADIR}
	mv ${WORKDIR}/data/games/vegastrike ${D}/${GAMES_DATADIR}/

	find ${D} -type d -name cvs -exec rm -rf '{}' \; >& /dev/null

	prepgamesdirs
}

pkg_postinst() {
	einfo "run vsinstall to setup your account"
	einfo "then run vslauncher to start Vega Strike"
	games_pkg_postinst
}
