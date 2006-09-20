# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/fish-fillets/fish-fillets-0.7.3.ebuild,v 1.4 2006/09/20 23:06:58 vapier Exp $

inherit autotools eutils games

DATA_PV="0.7.1"
DESCRIPTION="Underwater puzzle game - find a safe way out"
HOMEPAGE="http://fillets.sourceforge.net/"
SRC_URI="mirror://sourceforge/fillets/fillets-ng-${PV}.tar.gz
	mirror://sourceforge/fillets/fillets-ng-data-${DATA_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="X"

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-mixer-1.2.5
	>=media-libs/sdl-image-1.2.2
	X? ( x11-libs/libX11 )
	media-libs/sdl-ttf
	>=dev-lang/lua-5"

S=${WORKDIR}/fillets-ng-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-check-for-X.patch
	epatch "${FILESDIR}"/${P}-custom-datadir.patch
	epatch "${FILESDIR}"/${P}-no-local-paths.patch
	epatch "${FILESDIR}"/${P}-use-lua-pkg-config.patch
	eautoreconf
}

src_compile() {
	egamesconf $(use_with X) || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	insinto "${GAMES_DATADIR}/${PN}"
	cd "${WORKDIR}"/fillets-ng-data-${DATA_PV} || die
	rm -f COPYING
	doins -r * || die "doins failed"
	newicon images/icon.png fillets.png
	make_desktop_entry fillets FishFillets fillets.png
	prepgamesdirs
}
