# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xgalaga/xgalaga-2.0.34-r6.ebuild,v 1.6 2008/12/18 21:30:29 darkside Exp $

inherit eutils games flag-o-matic

DEB_VER=30
DESCRIPTION="A Galaga clone with additional features"
HOMEPAGE="http://rumsey.org/xgal.html"
SRC_URI="http://http.us.debian.org/debian/pool/main/x/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/x/${PN}/${PN}_${PV}-${DEB_VER}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXpm
	x11-libs/libXext
	x11-libs/libXt"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-xpaths.patch #79496
	epatch "${WORKDIR}"/${PN}_${PV}-${DEB_VER}.diff
	sed -i \
		-e "/LEVELDIR\|SOUNDDIR/ s:prefix:datadir/${PN}:" \
		-e "/\/scores/ s:prefix:localstatedir/${PN}:" configure \
		|| die "sed configure failed"
	sed -i \
		-e '/SOUNDDEFS/ s:@prefix@:@prefix@/bin:' Makefile.in \
		|| die "sed Makefile.in failed"
	append-ldflags -Wl,--no-as-needed #247331
}

src_compile() {
	egamesconf || die
	emake CPPFLAGS="-D__NO_STRING_INLINES" || die "emake failed"
}

src_install() {
	dogamesbin xgalaga xgal.sndsrv.linux || die "dogamesbin failed"
	dodoc README README.SOUND CHANGES
	newman xgal.6x xgal.6

	insinto "${GAMES_DATADIR}/${PN}/sounds"
	doins sounds/*.raw || die "doins failed"

	insinto "${GAMES_DATADIR}/${PN}/levels"
	doins levels/*.xgl || die "doins failed"

	newicon xgalaga-icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} XGalaga

	dodir "${GAMES_STATEDIR}/${PN}"
	touch "${D}${GAMES_STATEDIR}/${PN}/scores"
	fperms 660 "${GAMES_STATEDIR}/${PN}/scores"
	prepgamesdirs
}
