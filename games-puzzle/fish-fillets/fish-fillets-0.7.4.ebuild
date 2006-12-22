# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/fish-fillets/fish-fillets-0.7.4.ebuild,v 1.1 2006/12/22 08:25:43 vapier Exp $

inherit eutils games

DATA_PV="0.7.4"
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

src_compile() {
	egamesconf \
		--datadir="${GAMES_DATADIR}/${PN}" \
		$(use_with X) \
		|| die
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
