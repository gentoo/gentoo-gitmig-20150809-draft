# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/trophy/trophy-1.1.3.ebuild,v 1.7 2005/03/25 06:33:21 mr_bones_ Exp $

inherit eutils flag-o-matic games

MY_P="${P}-src"
DESCRIPTION="2D Racing Game"
HOMEPAGE="http://trophy.sourceforge.net/"
SRC_URI="mirror://sourceforge/trophy/${MY_P}.tar.gz
	mirror://debian/pool/main/t/trophy/${PN}_${PV}-2.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="=dev-games/clanlib-0.6.5*
	>=media-libs/hermes-1.3.2
	>=sys-libs/zlib-1.1.3"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${PN}_${PV}-2.diff"
	find -name ".cvsignore" -exec rm -f \{\} \;
	sed -i \
		-e '/^EXTERN_LIBS/s:= := ${LDFLAGS} :' \
		-e 's:-O3::' \
		trophy/Makefile.in \
		|| die "sed failed"
}

src_compile() {
	cd trophy
	autoconf || die "autoconf failed"
	append-flags -I${ROOT}/usr/include/clanlib-0.6.5
	append-ldflags -L${ROOT}/usr/lib/clanlib-0.6.5
	egamesconf || die
	emake || die "emake failed"
}

src_install() {
	dogamesbin trophy/trophy || die
	dodir "${GAMES_DATADIR}/trophy/resources"
	cp -R trophy/resources/* "${D}${GAMES_DATADIR}/trophy/resources" \
		|| die "cp failed"
	cp trophy/resources.scr "${D}${GAMES_DATADIR}/trophy/" \
		|| die "cp failed"
	dodoc AUTHORS README TODO ChangeLog
	doman debian/trophy.6
	doicon debian/trophy.xpm
	make_desktop_entry trophy Trophy trophy.xpm
	prepgamesdirs
}
