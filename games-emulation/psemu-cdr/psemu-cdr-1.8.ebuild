# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-cdr/psemu-cdr-1.8.ebuild,v 1.1 2003/09/09 16:26:50 vapier Exp $

inherit games eutils

DESCRIPTION="PSEmu plugin to read from CD-ROM"
HOMEPAGE="http://www.pcsx.net/"
SRC_URI="http://linuzappz.pcsx.net/downloads/cdr-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gtk gtk2"

DEPEND="|| (
		gtk2? ( =x11-libs/gtk+-2* )
		gtk? ( =x11-libs/gtk+-1* )
		=x11-libs/gtk+-2*
	)
	dev-util/pkgconfig"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-makefile-cflags.patch
}

src_compile() {
	local gtk
	if [ `use gtk2` ] ; then
		gtk=gtk+2
	elif [ `use gtk` ] ; then
		gtk=gtk
	else
		gtk=gtk+2
	fi
	cd src
	emake OPTFLAGS="${CFLAGS}" GUI="${gtk}" || die
}

src_install() {
	exeinto ${GAMES_LIBDIR}/psemu/plugins
	doexe src/libcdr-*
	exeinto ${GAMES_LIBDIR}/psemu/cfg
	doexe src/cfg-gtk*/cfgCdr
	insinto ${GAMES_LIBDIR}/psemu/cfg
	doins cdr.cfg
	dodoc ReadMe.txt
	prepgamesdirs
}
