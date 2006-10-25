# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/supertuxkart/supertuxkart-0.2.ebuild,v 1.5 2006/10/25 23:53:32 nyhm Exp $

inherit games

DESCRIPTION="A kart racing game starring Tux, the linux penguin (improved fork of TuxKart)"
HOMEPAGE="http://supertuxkart.berlios.de/"
SRC_URI="http://download.berlios.de/${PN}/SuperTuxKart-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=">=media-libs/plib-1.8.4
	virtual/opengl"

src_compile() {
	egamesconf --datadir="${GAMES_DATADIR_BASE}" || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README
	prepgamesdirs
}

