# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/fish-fillets/fish-fillets-0.3.0.ebuild,v 1.3 2004/06/04 18:40:08 jhuebel Exp $

inherit games

S="${WORKDIR}/fillets-ng-${PV}"
DESCRIPTION="Underwater puzzle game - find a safe way out"
HOMEPAGE="http://fillets.sf.net"
SRC_URI="mirror://sourceforge/fillets/fillets-ng-${PV}.tar.gz
	mirror://sourceforge/fillets/fillets-ng-${PV}-data.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64"
SLOT="0"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-mixer-1.2.5
	>=media-libs/sdl-image-1.2.2
	dev-libs/boost
	>=dev-lang/lua-5"

src_compile() {
	CPPFLAGS="-DSYSTEM_DATA_DIR=\"\\\"${GAMES_DATADIR}/${PN}\\\"\"" \
	egamesconf \
		--with-lua="/usr" || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	cd ${S}-data
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r font music sound doc images script "${D}${GAMES_DATADIR}/${PN}" \
		|| die "cp failed"
	prepgamesdirs
}
