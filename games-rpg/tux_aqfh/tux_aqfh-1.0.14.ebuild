# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/tux_aqfh/tux_aqfh-1.0.14.ebuild,v 1.3 2004/08/01 11:45:37 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A puzzle game starring Tux, the linux penguin"
HOMEPAGE="http://tuxaqfh.sourceforge.net/"
SRC_URI="http://tuxaqfh.sourceforge.net/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~amd64 ~ppc"
IUSE=""

RDEPEND=">=media-libs/plib-1.8.0
	virtual/x11
	virtual/opengl"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-fix-paths.patch
	autoreconf || die "couldnt autoreconf"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS CHANGES README NEWS
	dohtml doc/*.{html,png}
	prepgamesdirs
}
