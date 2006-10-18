# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/tux_aqfh/tux_aqfh-1.0.14.ebuild,v 1.8 2006/10/18 18:19:20 nyhm Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest
inherit autotools eutils games

DESCRIPTION="A puzzle game starring Tux, the linux penguin"
HOMEPAGE="http://tuxaqfh.sourceforge.net/"
SRC_URI="http://tuxaqfh.sourceforge.net/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ppc x86"
IUSE=""

RDEPEND="virtual/glut
	x11-libs/libXmu
	x11-libs/libXi
	virtual/glu
	virtual/opengl"
DEPEND="${RDEPEND}
	>=media-libs/plib-1.8.0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-fix-paths.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS CHANGES README
	dohtml doc/*.{html,png}
	prepgamesdirs
}
