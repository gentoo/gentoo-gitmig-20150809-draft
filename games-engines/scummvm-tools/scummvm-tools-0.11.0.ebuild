# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/scummvm-tools/scummvm-tools-0.11.0.ebuild,v 1.1 2008/02/11 07:35:43 mr_bones_ Exp $

inherit toolchain-funcs games

DESCRIPTION="utilities for the SCUMM game engine"
HOMEPAGE="http://scummvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/scummvm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libpng"

src_compile() {
	emake \
	CC=$(tc-getCC) \
	CXX=$(tc-getCXX) \
	CFLAGS="${CFLAGS} -DUNIX" \
	|| die "emake failed"
}

src_install() {
	local f
	for f in $(find . -type f -perm +1 -print); do
		newgamesbin $f ${PN}-${f##*/} || die "newgamesbin $f failed"
	done
	dodoc README
	prepgamesdirs
}
