# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/c++robots/c++robots-0.ebuild,v 1.2 2004/02/20 06:43:58 mr_bones_ Exp $

inherit games

DESCRIPTION="ongoing 'King of the Hill' (KotH) tournament"
HOMEPAGE="http://www.gamerz.net/c++robots/"
SRC_URI="http://www.gamerz.net/c++robots/c++robots.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="static"

DEPEND="virtual/glibc"

S="${WORKDIR}/${PN}"

src_compile() {
	patch -p0 < ${FILESDIR}/proper-coding.patch

	local myldflags="${LDFLAGS}"
	use static && myldflags="${myldflags} -static"
	emake CFLAGS="${CFLAGS}" LDFLAGS="${myldflags}" || die
}

src_install() {
	dogamesbin combat cylon target tracker
	dodoc README
	prepgamesdirs
}
