# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mekanix/mekanix-065.ebuild,v 1.2 2004/02/20 06:26:47 mr_bones_ Exp $

inherit games

DESCRIPTION="SG-1000, SC-3000, SF-7000, SSC, SMS, GG, COLECO, and OMV emulator"
HOMEPAGE="http://www.smspower.org/meka/"
SRC_URI="http://www.smspower.org/meka/${PN}${PV}.zip"

LICENSE="mekanix"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11"

S=${WORKDIR}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}
	chmod a+x meka.exe
	cp * ${D}/${dir}/
	dogamesbin ${FILESDIR}/mekanix
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/mekanix
	prepgamesdirs
}
