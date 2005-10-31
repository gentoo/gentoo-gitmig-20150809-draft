# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/scummvm-tools/scummvm-tools-0.8.0.ebuild,v 1.1 2005/10/31 01:31:16 vapier Exp $

inherit games

DESCRIPTION="utilities for the SCUMM game engine"
HOMEPAGE="http://scummvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/scummvm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/tools-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '/CFLAGS/s: -g -O : :' Makefile
}

src_install() {
	local f
	for f in $(find -type f -perm +1 -printf '%f ') ; do
		newgamesbin $f ${PN}-$f || die "newgamesbin $f failed"
	done
	dodoc README
	prepgamesdirs
}
