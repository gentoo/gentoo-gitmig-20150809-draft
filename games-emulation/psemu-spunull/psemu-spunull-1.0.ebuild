# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-spunull/psemu-spunull-1.0.ebuild,v 1.5 2007/04/09 17:28:43 nyhm Exp $

inherit eutils games

DESCRIPTION="PSEmu plugin to use a null sound driver"
HOMEPAGE="http://www.pcsx.net/"
SRC_URI="http://linuzappz.pcsx.net/downloads/spunull-${PV}.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
IUSE=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PV}-makefile-cflags.patch
}

src_compile() {
	cd src
	emake OPTFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dodoc ReadMe.txt
	cd src
	exeinto "$(games_get_libdir)"/psemu/plugins
	doexe libspunull-* || die "doexe failed"
	prepgamesdirs
}
