# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-cdriso/psemu-cdriso-1.4.ebuild,v 1.3 2004/02/13 15:40:11 dholm Exp $

inherit games eutils

DESCRIPTION="PSEmu plugin to read CD-images"
HOMEPAGE="http://www.pcsx.net/"
SRC_URI="http://linuzappz.pcsx.net/downloads/cdriso-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="sys-libs/zlib
	app-arch/bzip2
	=x11-libs/gtk+-1*
	dev-util/pkgconfig"

S=${WORKDIR}/cdriso

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-makefile-cflags.patch
}

src_compile() {
	cd src/Linux
	emake OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc ReadMe.txt
	cd src/Linux
	exeinto ${GAMES_LIBDIR}/psemu/plugins
	doexe libcdriso-*
	exeinto ${GAMES_LIBDIR}/psemu/cfg
	doexe cfgCdrIso
	prepgamesdirs
}

