# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/fish-fillets/fish-fillets-0.4.1.ebuild,v 1.1 2004/07/26 03:10:26 mr_bones_ Exp $

inherit games

DESCRIPTION="Underwater puzzle game - find a safe way out"
HOMEPAGE="http://fillets.sf.net"
SRC_URI="mirror://sourceforge/fillets/fillets-ng-${PV}.tar.gz
	mirror://sourceforge/fillets/fillets-ng-data-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-mixer-1.2.5
	>=media-libs/sdl-image-1.2.2
	media-libs/sdl-ttf
	dev-libs/boost
	>=dev-lang/lua-5"

S="${WORKDIR}/fillets-ng-${PV}"

src_compile() {
	CPPFLAGS="-DSYSTEM_DATA_DIR=\"\\\"${GAMES_DATADIR}/${PN}\\\"\"" \
	egamesconf \
		--with-lua="/usr" || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	cd ../fillets-ng-data-${PV}
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r font music sound doc images script "${D}${GAMES_DATADIR}/${PN}" \
		|| die "cp failed"
	prepgamesdirs
}
