# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/armagetronad-ded/armagetronad-ded-0.2.7.1.ebuild,v 1.1 2005/06/08 20:25:19 wolf31o2 Exp $


inherit flag-o-matic eutils games

DESCRIPTION="3d tron lightcycles, just like the movie"
HOMEPAGE="http://armagetronad.sourceforge.net/"
SRC_URI="mirror://sourceforge/armagetronad/armagetronad-0.2.7.1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

S="${WORKDIR}/armagetronad-${PV}"

RDEPEND="virtual/x11
	virtual/opengl
	media-libs/libsdl
	media-libs/sdl-image
	sys-libs/zlib
	media-libs/libpng"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_compile() {
	filter-flags -fno-exceptions
	egamesconf --disable-glout || die "egamesconf failed"
	emake || die "emake failed"
	make documentation || die "make doc failed"
}

src_install() {
	dodoc COPYING.txt
	dohtml doc/*.html
	docinto html/net
	dohtml doc/net/*.html
	dodir "${GAMES_LIBDIR}/${PN}" "${GAMES_DATADIR}/${PN}" "${GAMES_SYSCONFDIR}/${PN}"
	insinto "${GAMES_LIBDIR}/${PN}"
	doins src/tron/${PN}icated src/network/armagetronad-* || die "copying files"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r log language || die "copying files"
	insinto "${GAMES_SYSCONFDIR}/${PN}"
	doins -r config/* || die "copying files"
	newgamesbin "${FILESDIR}/${PN}" ${PN} \
		|| die "Error: newgamesbin failed"
	prepgamesdirs
}
