# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-cdr/psemu-cdr-1.8.ebuild,v 1.8 2006/09/26 18:32:03 nyhm Exp $

inherit eutils games

DESCRIPTION="PSEmu plugin to read from CD-ROM"
HOMEPAGE="http://www.pcsx.net/"
SRC_URI="http://linuzappz.pcsx.net/downloads/cdr-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-2*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PV}-makefile-cflags.patch
	sed -i '/STRIP/d' src/{,cfg-gtk2/}Makefile || die "sed failed"
}

src_compile() {
	emake -C src OPTFLAGS="${CFLAGS}" GUI="gtk+2" || die "emake failed"
}

src_install() {
	exeinto "${GAMES_LIBDIR}"/psemu/plugins
	doexe src/libcdr-* || die "doexe failed (1)"
	exeinto "${GAMES_LIBDIR}"/psemu/cfg
	doexe src/cfg-gtk*/cfgCdr || die "doexe failed(2)"
	insinto "${GAMES_LIBDIR}"/psemu/cfg
	doins cdr.cfg || die "doins failed"
	dodoc ReadMe.txt
	prepgamesdirs
}
