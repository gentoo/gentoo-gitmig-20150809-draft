# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/spacehulk/spacehulk-1.4.99.ebuild,v 1.10 2008/07/27 21:25:38 carlo Exp $

EAPI=1

inherit qt3 games

DESCRIPTION="A boardgame in the world of Warhammer 40k"
HOMEPAGE="http://r.vinot.free.fr/spacehulk/"
SRC_URI="http://freesoftware.fsf.org/download/spacehulk/main.pkg/${PV}/${P}.tar.gz
	http://freesoftware.fsf.org/download/spacehulk/themespack.pkg/1.0/spacehulk-themespack-1.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="xinerama"

DEPEND="x11-libs/qt:3
	media-libs/libpng
	media-libs/jpeg
	xinerama? ( x11-libs/libXinerama )"

src_compile() {
	egamesconf \
		$(use_with xinerama) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	insinto "${GAMES_DATADIR}"/${PN}/themes
	doins -r ../themes/* || die "doins failed"
	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
