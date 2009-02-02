# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xgalaga/xgalaga-2.0.34-r6.ebuild,v 1.8 2009/02/02 13:26:38 tupone Exp $

EAPI=2
inherit eutils games

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

src_prepare() {
	epatch "${FILESDIR}"/${P}-xpaths.patch #79496
	epatch "${WORKDIR}"/${PN}_${PV}-${DEB_VER}.diff
	sed -i \
		-e "/LEVELDIR\|SOUNDDIR/ s:prefix:datadir/${PN}:" \
		-e "/\/scores/ s:prefix:localstatedir/${PN}:" configure \
		|| die "sed configure failed"
	sed -i \
		-e '/SOUNDDEFS/ s:@prefix@:@prefix@/bin:' Makefile.in \
		|| die "sed Makefile.in failed"
	epatch "${FILESDIR}"/${P}-as-needed.patch
}

src_compile() {
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
