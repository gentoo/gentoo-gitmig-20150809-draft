# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/trophy/trophy-1.1.3.ebuild,v 1.8 2006/10/18 20:27:37 nyhm Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest
inherit autotools eutils flag-o-matic toolchain-funcs games

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
	>=media-libs/hermes-1.3.2"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${PN}_${PV}-2.diff"
	find -name ".cvsignore" -exec rm -f \{\} \;
	cd trophy
	sed -i \
		-e '/^EXTERN_LIBS/s:= := ${LDFLAGS} :' \
		-e 's:-O3::' \
		Makefile.in \
		|| die "sed failed"
	eautoreconf
}

src_compile() {
	cd trophy
	tc-export CXX
	append-flags $(clanlib0.6-config --cflags)
	append-ldflags $(clanlib0.6-config --libs)
	egamesconf || die
	emake || die "emake failed"
}

src_install() {
	dodoc AUTHORS README TODO ChangeLog
	doman debian/trophy.6
	doicon debian/trophy.xpm
	make_desktop_entry trophy Trophy trophy.xpm
	cd trophy
	dogamesbin trophy || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r resources resources.scr || die "doins failed"
	prepgamesdirs
}
