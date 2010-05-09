# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/burgerspace/burgerspace-1.8.3.ebuild,v 1.5 2010/05/09 18:27:56 armin76 Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="Clone of the 1982 BurgerTime video game by Data East"
HOMEPAGE="http://perso.b2b2c.ca/sarrazip/dev/burgerspace.html"
SRC_URI="http://perso.b2b2c.ca/sarrazip/dev/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-games/flatzebra-0.1.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-gcc43.patch
	AT_M4DIR=macros eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README THANKS
	prepgamesdirs
}
