# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-spunull/psemu-spunull-1.0.ebuild,v 1.3 2004/05/27 01:50:08 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="PSEmu plugin to use a null sound driver"
HOMEPAGE="http://www.pcsx.net/"
SRC_URI="http://linuzappz.pcsx.net/downloads/spunull-${PV}.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
IUSE=""

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${PV}-makefile-cflags.patch"
}

src_compile() {
	cd src
	emake OPTFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dodoc ReadMe.txt
	cd src
	exeinto "${GAMES_LIBDIR}/psemu/plugins"
	doexe libspunull-*
	prepgamesdirs
}
