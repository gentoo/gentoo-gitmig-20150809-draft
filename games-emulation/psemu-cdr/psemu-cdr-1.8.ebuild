# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-cdr/psemu-cdr-1.8.ebuild,v 1.2 2003/11/22 01:29:42 mr_bones_ Exp $

inherit games eutils

S=${WORKDIR}
DESCRIPTION="PSEmu plugin to read from CD-ROM"
HOMEPAGE="http://www.pcsx.net/"
SRC_URI="http://linuzappz.pcsx.net/downloads/cdr-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gtk2"

DEPEND="gtk2? ( =x11-libs/gtk+-2* )
	!gtk2? ( =x11-libs/gtk+-1* )
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-makefile-cflags.patch
}

src_compile() {
	local gtk
	if [ `use gtk2` ] ; then
		gtk=gtk+2
	else
		gtk=gtk
	fi
	cd src
	emake OPTFLAGS="${CFLAGS}" GUI="${gtk}" || die "emake failed"
}

src_install() {
	exeinto ${GAMES_LIBDIR}/psemu/plugins
	doexe src/libcdr-*        || die "doexe failed (1)"
	exeinto ${GAMES_LIBDIR}/psemu/cfg
	doexe src/cfg-gtk*/cfgCdr || die "doexe failed(2)"
	insinto ${GAMES_LIBDIR}/psemu/cfg
	doins cdr.cfg             || die "doins failed"
	dodoc ReadMe.txt          || die "dodoc failed"
	prepgamesdirs
}
