# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/senken/senken-0.3.0.ebuild,v 1.3 2004/09/19 08:29:29 mr_bones_ Exp $

inherit games

DESCRIPTION="city simulation game"
HOMEPAGE="http://www.contrib.andrew.cmu.edu/~tmartin/senken/"
SRC_URI="http://www.contrib.andrew.cmu.edu/~tmartin/senken/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

RDEPEND="virtual/x11
	>=x11-libs/gtk+-2
	>=media-libs/libsdl-1.2.4
	media-libs/sdl-image"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:/usr/local/share:${GAMES_DATADIR}:" \
		lib/utils.h \
		|| die "sed lib/utils.h failed"

}
src_compile() {
	egamesconf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README TODO

	dodir "${GAMES_DATADIR}"
	mv "${D}/${GAMES_PREFIX}/share/senken" "${D}/${GAMES_DATADIR}/" \
		|| die "mv failed"
	rm -rf "${D}/${GAMES_PREFIX}"/{include,lib,man,share}

	insinto "${GAMES_DATADIR}/senken/img"
	doins img/*.png

	find "${D}/${GAMES_DATADIR}/" -type f -exec chmod a-x \{\} \;
	find "${D}/${GAMES_DATADIR}/" -name "Makefile.*" -exec rm -f \{\} \;

	prepgamesdirs
}
