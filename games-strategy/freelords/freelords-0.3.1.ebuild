# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freelords/freelords-0.3.1.ebuild,v 1.1 2004/01/04 09:00:06 mr_bones_ Exp $

inherit games

DESCRIPTION="Free Warlords clone"
HOMEPAGE="http://www.freelords.org/"
SRC_URI="mirror://sourceforge/freelords/${P}.tar.bz2"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="dev-libs/expat
	dev-util/pkgconfig
	>=media-libs/libsdl-1.2.0
	>=media-libs/sdl-image-1.2.0
	>=media-libs/paragui-1.0.4
	>=dev-libs/libsigc++-1.2.0
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:/etc/freelordsrc:${GAMES_SYSCONFDIR}/freelordsrc:" src/main.cpp \
			|| die "sed src/main.cpp failed"
}

src_compile() {
	egamesconf --disable-paraguitest || die
	emake CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodir "${GAMES_SYSCONFDIR}"
	mv "${D}/etc/freelordsrc" "${D}/${GAMES_SYSCONFDIR}/"

	dodoc AUTHORS BUGS ChangeLog DEPENDENCIES HACKER NEWS README TODO doc/* \
		|| die "dodoc failed"

	prepgamesdirs
}
