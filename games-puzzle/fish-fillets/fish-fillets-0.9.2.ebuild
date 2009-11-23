# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/fish-fillets/fish-fillets-0.9.2.ebuild,v 1.3 2009/11/23 13:43:15 maekke Exp $

EAPI=2
inherit autotools eutils games

DATA_PV="0.9.2"
DESCRIPTION="Underwater puzzle game - find a safe way out"
HOMEPAGE="http://fillets.sourceforge.net/"
SRC_URI="mirror://sourceforge/fillets/fillets-ng-${PV}.tar.gz
	mirror://sourceforge/fillets/fillets-ng-data-${DATA_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2[audio,video]
	>=media-libs/sdl-mixer-1.2.5[vorbis]
	>=media-libs/sdl-image-1.2.2[png]
	media-libs/smpeg
	x11-libs/libX11
	media-libs/sdl-ttf
	dev-libs/fribidi
	>=dev-lang/lua-5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/fillets-ng-${PV}

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-gcc43.patch" \
		"${FILESDIR}/${P}-fribidi.patch"

	#.mod was renamed to .fmod in lua 5.1.3 - bug #223271
	sed -i \
		-e 's/\.mod(/.fmod(/' \
		$(grep -rl "\.mod\>" "${WORKDIR}"/fillets-ng-data-${DATA_PV}) \
		|| die "sed failed"
	rm -f missing
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--datadir="${GAMES_DATADIR}/${PN}"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	insinto "${GAMES_DATADIR}/${PN}"
	cd "${WORKDIR}"/fillets-ng-data-${DATA_PV} || die
	rm -f COPYING
	doins -r * || die "doins failed"
	newicon images/icon.png fillets.png
	make_desktop_entry fillets FishFillets fillets
	prepgamesdirs
}
