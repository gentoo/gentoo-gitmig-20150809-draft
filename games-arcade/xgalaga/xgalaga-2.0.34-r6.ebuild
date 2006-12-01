# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xgalaga/xgalaga-2.0.34-r6.ebuild,v 1.4 2006/12/01 20:27:26 wolf31o2 Exp $

inherit eutils games

DEB_VER=30
DESCRIPTION="Galaga game clone."
HOMEPAGE="http://rumsey.org/xgal.html"
SRC_URI="http://http.us.debian.org/debian/pool/main/x/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/x/${PN}/${PN}_${PV}-${DEB_VER}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

DEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXpm
	x11-proto/xproto
	x11-libs/libXext
	x11-libs/libXt"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}"/${P}-xpaths.patch #79496
	epatch "${WORKDIR}"/${PN}_${PV}-${DEB_VER}.diff
	sed -i \
		-e "/LEVELDIR\|SOUNDDIR/ s:prefix:datadir/${PN}:" \
		-e "/\/scores/ s:prefix:localstatedir/${PN}:" configure \
		|| die "sed configure failed"
	sed -i \
		-e '/SOUNDDEFS/ s:@prefix@:@prefix@/bin:' Makefile.in \
		|| die "sed Makefile.in failed"
}

src_compile() {
	egamesconf || die
	emake CPPFLAGS="-D__NO_STRING_INLINES" || die "compile problem"
}

src_install() {
	dogamesbin xgalaga xgal.sndsrv.linux || die "dogamesbin failed"
	dodoc README README.SOUND CHANGES
	newman xgal.6x xgal.6

	insinto "${GAMES_DATADIR}/${PN}/sounds"
	doins sounds/*.raw || die "doins failed"

	insinto "${GAMES_DATADIR}/${PN}/levels"
	doins levels/*.xgl || die "doins failed"

	insinto /usr/share/pixmaps
	doins xgalaga-icon.xpm || die "doins failed"

	make_desktop_entry xgalaga xgalaga xgalaga-icon.xpm

	dodir "${GAMES_STATEDIR}/${PN}"
	touch "${D}${GAMES_STATEDIR}/${PN}/scores"
	fperms 660 "${GAMES_STATEDIR}/${PN}/scores"
	prepgamesdirs
}
