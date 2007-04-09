# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-cdr/psemu-cdr-1.8.ebuild,v 1.9 2007/04/09 15:56:39 nyhm Exp $

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
	exeinto "$(games_get_libdir)"/psemu/plugins
	doexe src/libcdr-* || die "doexe failed (1)"
	exeinto "$(games_get_libdir)"/psemu/cfg
	doexe src/cfg-gtk*/cfgCdr || die "doexe failed(2)"
	insinto "$(games_get_libdir)"/psemu/cfg
	doins cdr.cfg || die "doins failed"
	dodoc ReadMe.txt
	prepgamesdirs
}
