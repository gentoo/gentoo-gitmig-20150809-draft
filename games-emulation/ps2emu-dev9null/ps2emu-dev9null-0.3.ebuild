# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-dev9null/ps2emu-dev9null-0.3.ebuild,v 1.2 2007/04/06 20:46:18 nyhm Exp $

inherit games

DESCRIPTION="PSEmu2 NULL Sound plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/0.8release/dev9null${PV//.}.rar"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-1.2*"
DEPEND="${RDEPEND}
	app-arch/unrar"

S=${WORKDIR}/dev9null${PV//.}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:-O2 -fomit-frame-pointer:$(OPTFLAGS):' src/Makefile \
		|| die "sed failed"
}

src_compile() {
	cd src
	emake OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc ReadMe.txt
	exeinto "$(games_get_libdir)"/ps2emu/plugins
	newexe src/libDEV9null.so libDEV9null-${PV}.so || die
	prepgamesdirs
}
