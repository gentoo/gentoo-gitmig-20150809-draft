# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/ps2emu-padxwin/ps2emu-padxwin-0.3.ebuild,v 1.1 2003/08/15 01:26:15 vapier Exp $

inherit games

DESCRIPTION="PSEmu2 PAD plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/0.4release/PADxwin-${PV}.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1*"

S=${WORKDIR}/PADxwin

src_unpack() {
	unpack ${A}
	tar -xf PADxwin-${PV} || die "unpacking tar"
	cd ${S}
	epatch ${FILESDIR}/${PV}-makefile.patch
}

src_compile() {
	cd Src
	emake OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc ReadMe.txt
	cd Src
	exeinto ${GAMES_LIBDIR}/ps2emu/plugins
	doexe lib*
	prepgamesdirs
}
