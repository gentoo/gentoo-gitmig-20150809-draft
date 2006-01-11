# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freecnc/freecnc-0.2.0.ebuild,v 1.7 2006/01/11 21:34:29 mr_bones_ Exp $

inherit games flag-o-matic eutils

DESCRIPTION="SDL-rewrite of the classical real time strategy hit Command & Conquer"
HOMEPAGE="http://freecnc-sf.holarse.net/"
SRC_URI="mirror://sourceforge/freecnc/freecnc++-${PV}-src.tar.bz2
	nocd? ( ftp://ftp.westwood.com/pub/cc1/previews/demo/cc1demo1.zip )
	nocd? ( ftp://ftp.westwood.com/pub/cc1/previews/demo/cc1demo2.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="zlib nocd"

RDEPEND="media-libs/libsdl
	media-libs/sdl-net
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/freecnc++

src_unpack() {
	unpack freecnc++-${PV}-src.tar.bz2
	if use nocd ; then
		mkdir data ; cd data
		unpack cc1demo1.zip cc1demo2.zip
		for f in * ; do
			mv ${f} $(echo ${f} | awk '{print tolower($1)}') || die "moving $f"
		done
	fi
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-makefile-cflags.patch \
		"${FILESDIR}"/${PV}-remove-root.patch \
		"${FILESDIR}"/${PV}-gentoo-paths.patch \
		"${FILESDIR}"/${P}-endian.patch
	rm -f src/include/endian.h
	sed -i \
		-e "s:GENTOO_LOGDIR:${GAMES_LOGDIR}:" \
		-e "s:GENTOO_CONFDIR:${GAMES_SYSCONFDIR}/${PN}/:" \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}/:" \
		src/freecnc.cpp src/vfs/vfs.cpp \
		|| die "sed failed"
}

src_compile() {
	emake EXTRACFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	exeinto "${GAMES_LIBDIR}"/${PN}
	doexe freecnc *.vfs
	dogamesbin "${FILESDIR}"/freecnc || die "dogamesbin failed"
	dosed "s:GENTOO_DIR:${GAMES_LIBDIR}/${PN}:" ${GAMES_BINDIR}/freecnc
	insinto "${GAMES_DATADIR}"/${PN}/conf
	doins conf/*
	insinto "${GAMES_SYSCONFDIR}"/${PN}
	doins conf/*
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	if use nocd ; then
		cd "${WORKDIR}"/data
		insinto "${GAMES_DATADIR}"/${PN}
		doins *.mix *.aud || die "doins failed"
		dodoc *.txt
	fi
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "If you have the C&C games, then just copy the .mix"
	einfo "to ${GAMES_DATADIR}/${PN}"
	einfo "Otherwise, re-emerge freecnc with 'nocd' in your USE."
}
