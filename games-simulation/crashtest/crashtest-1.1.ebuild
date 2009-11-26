# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/crashtest/crashtest-1.1.ebuild,v 1.2 2009/11/26 20:03:31 maekke Exp $

EAPI=2
inherit eutils flag-o-matic games

DESCRIPTION="Educational car crash simulator"
HOMEPAGE="http://bram.creative4vision.nl/crashtest/"
SRC_URI="http://bram.creative4vision.nl/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/fltk:1.1[opengl]
	dev-games/ode
	media-libs/alsa-lib
	virtual/opengl
	virtual/glu
	virtual/glut"
DEPEND="${RDEPEND}
	>=media-libs/plib-1.8.4"

S=${WORKDIR}/${P}/src-${PN}

src_prepare() {
	epatch "${FILESDIR}/${P}"-gentoo.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		-e "s:@GENTOO_BINDIR@:${GAMES_BINDIR}:" \
		Makefile ${PN}.cxx \
		|| die "sed failed"
	append-flags -DHAVE_ISNANF
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README
	make_desktop_entry ${PN} Crashtest
	prepgamesdirs
}
