# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/tecnoballz/tecnoballz-0.92.ebuild,v 1.2 2008/10/10 19:33:19 nyhm Exp $

inherit eutils autotools games

DESCRIPTION="An exciting Brick Breaker"
HOMEPAGE="http://linux.tlk.fr/games/TecnoballZ/"
SRC_URI="${HOMEPAGE}download/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/libmikmod"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-automake.patch
	mv man/${PN}.fr.6 man/fr/${PN}.6 || die "failed moving man pages"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS CHANGES NEWS README
	fperms g+w "${GAMES_STATEDIR}"/${PN}.hi || die "fperms failed"
	prepgamesdirs
}

pkg_postinst() {
	built_with_use "media-libs/sdl-mixer" mikmod \
		|| ewarn "To have background music, emerge sdl-mixer with USE=mikmod"
	games_pkg_postinst
}
