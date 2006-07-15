# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/scummvm-tools/scummvm-tools-0.9.0.ebuild,v 1.1 2006/07/15 05:19:57 mr_bones_ Exp $

inherit games

DESCRIPTION="utilities for the SCUMM game engine"
HOMEPAGE="http://scummvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/scummvm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libpng"

S=${WORKDIR}/tools-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^CC/d' \
		-e '/^CXX/d' \
		-e '/^CFLAGS/d' \
		-e '/CXX.*CFLAGS/s/CFLAGS/CXXFLAGS/' \
		Makefile \
		|| die "sed failed"
}

src_install() {
	local f
	for f in $(find -type f -perm +1 -printf '%f ') ; do
		newgamesbin $f ${PN}-$f || die "newgamesbin $f failed"
	done
	dodoc README
	prepgamesdirs
}
