# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/supertuxkart/supertuxkart-0.2.ebuild,v 1.10 2008/02/07 05:56:21 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A kart racing game starring Tux, the linux penguin (improved fork of TuxKart)"
HOMEPAGE="http://supertuxkart.sourceforge.net/"
SRC_URI="mirror://berlios/${PN}/SuperTuxKart-${PV}.tar.bz2
	mirror://gentoo/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND=">=media-libs/plib-1.8.4
	virtual/opengl"

src_compile() {
	egamesconf --datadir="${GAMES_DATADIR_BASE}" || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} SuperTuxKart
	dodoc AUTHORS NEWS README
	prepgamesdirs
}
