# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-cdriso/psemu-cdriso-1.4.ebuild,v 1.8 2005/09/26 17:47:57 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="PSEmu plugin to read CD-images"
HOMEPAGE="http://www.pcsx.net/"
SRC_URI="http://linuzappz.pcsx.net/downloads/cdriso-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="sys-libs/zlib
	app-arch/bzip2
	=x11-libs/gtk+-1*
	dev-util/pkgconfig"

S="${WORKDIR}/cdriso"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${PV}-makefile-cflags.patch"
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
