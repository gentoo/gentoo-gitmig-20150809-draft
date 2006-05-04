# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/scummvm-tools/scummvm-tools-0.8.0.ebuild,v 1.2 2006/05/04 06:45:39 josejx Exp $

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
	sed -i -e '/CFLAGS/s: -g -O : :' Makefile || die "sed failed"
	if use ppc; then
		sed -i -e '/DSCUMM_BIG/s:# CFLAGS:CFLAGS:' Makefile || die "sed failed"
	fi
}

src_install() {
	local f
	for f in $(find -type f -perm +1 -printf '%f ') ; do
		newgamesbin $f ${PN}-$f || die "newgamesbin $f failed"
	done
	dodoc README
	prepgamesdirs
}
