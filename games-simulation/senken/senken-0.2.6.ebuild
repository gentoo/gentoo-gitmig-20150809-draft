# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/senken/senken-0.2.6.ebuild,v 1.2 2004/02/20 07:33:25 mr_bones_ Exp $

inherit games

DESCRIPTION="city simulation game"
HOMEPAGE="http://www.contrib.andrew.cmu.edu/~tmartin/senken/"
SRC_URI="http://www.contrib.andrew.cmu.edu/~tmartin/senken/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1*
	>=sys-apps/sed-4
	virtual/x11
	>=media-libs/libsdl-1.2.4
	media-libs/sdl-image"

src_unpack() {
	unpack ${A}
	cd ${S} && \
	sed -i \
		-e "s:/usr/local/share:${GAMES_DATADIR}:" \
		lib/utils.h || die "sed lib/utils.h failed"

}
src_compile() {
	egamesconf `use_enable nls` || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS README TODO

	cd ${D}/${GAMES_PREFIX}
	dodir ${GAMES_DATADIR}
	mv share/senken ${D}/${GAMES_DATADIR}/
	rm -rf include lib man share

	insinto ${GAMES_DATADIR}/senken/img
	doins ${S}/img/*.png

	prepgamesdirs
}
