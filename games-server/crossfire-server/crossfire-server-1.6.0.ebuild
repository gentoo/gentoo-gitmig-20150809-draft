# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/crossfire-server/crossfire-server-1.6.0.ebuild,v 1.3 2004/06/01 20:07:29 mr_bones_ Exp $

inherit eutils games

MY_P="${P/-server}"
DESCRIPTION="server for the crossfire clients"
HOMEPAGE="http://crossfire.real-time.com/"
SRC_URI="mirror://sourceforge/crossfire/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="X"

DEPEND="virtual/glibc
	X? (
		virtual/x11
		media-libs/libpng )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	egamesconf $(use_with X x) || die
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog DEVELOPERS NEWS README TODO
	prepgamesdirs
}
