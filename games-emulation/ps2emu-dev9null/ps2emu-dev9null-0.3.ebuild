# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-dev9null/ps2emu-dev9null-0.3.ebuild,v 1.1 2005/08/07 04:51:24 vapier Exp $

inherit games

DESCRIPTION="PSEmu2 NULL Sound plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="http://www.pcsx2.net/download/0.8release/dev9null${PV//.}.rar"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-1*"
DEPEND="${RDEPEND}
	app-arch/unrar"

S=${WORKDIR}/dev9null${PV//.}

src_unpack() {
	unrar x -idq "${DISTDIR}"/${A} || die "unpacking failed"
	sed -i 's:-O2 -fomit-frame-pointer:$(OPTFLAGS):' ${S}/src/Makefile
}

src_compile() {
	cd src
	emake OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc ReadMe.txt
	exeinto "${GAMES_LIBDIR}"/ps2emu/plugins
	newexe src/libDEV9null.so libDEV9null-${PV}.so || die
	prepgamesdirs
}
