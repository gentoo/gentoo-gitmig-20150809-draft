# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freecnc/freecnc-0.2.1.31072003.ebuild,v 1.12 2007/04/04 20:20:07 nyhm Exp $

inherit flag-o-matic eutils games

DESCRIPTION="SDL-rewrite of the classical real time strategy hit Command & Conquer"
HOMEPAGE="http://www.freecnc.org/"
#mirror://sourceforge/freecnc/freecnc++-${PV}-src.tar.bz2
SRC_URI="mirror://gentoo/freecnc++-${PV}-src.tar.bz2
	nocd? ( ftp://ftp.westwood.com/pub/cc1/previews/demo/cc1demo1.zip )
	nocd? ( ftp://ftp.westwood.com/pub/cc1/previews/demo/cc1demo2.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="nocd"

RDEPEND="media-libs/libsdl
	media-libs/sdl-net"
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
	epatch \
		"${FILESDIR}"/${PV}-makefile-cflags.patch \
		"${FILESDIR}"/${PV}-remove-root.patch \
		"${FILESDIR}"/${PV}-gentoo-paths.patch \
		"${FILESDIR}"/${P}-gcc4.patch
	sed -i \
		-e "s:GENTOO_LOGDIR:${GAMES_LOGDIR}:" \
		-e "s:GENTOO_CONFDIR:${GAMES_SYSCONFDIR}/${PN}/:" \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}/:" \
		src/{freecnc,vfs/vfs}.cpp tools/audplay/audplay.cpp \
		|| die "sed failed"
}

src_compile() {
	emake linux EXTRACFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	exeinto "$(games_get_libdir)"/${PN}
	doexe freecnc *.vfs audplay shpview tmpinied || die "doexe failed"
	games_make_wrapper ${PN} ./freecnc "$(games_get_libdir)"/${PN}
	insinto "${GAMES_DATADIR}"/${PN}/conf
	doins conf/* || die "doins failed"
	insinto "${GAMES_SYSCONFDIR}"/${PN}
	doins conf/* || die "doins failed"
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
	elog "If you have the C&C games, then just copy the .mix"
	elog "to ${GAMES_DATADIR}/${PN}"
	elog "Otherwise, re-emerge freecnc with 'nocd' in your USE."
}
