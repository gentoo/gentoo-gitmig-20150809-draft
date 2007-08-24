# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/crashtest/crashtest-1.0.ebuild,v 1.3 2007/08/24 14:21:01 nyhm Exp $

inherit eutils games

DESCRIPTION="Educational car crash simulator"
HOMEPAGE="http://bram.creative4vision.nl/crashtest/"
SRC_URI="http://bram.creative4vision.nl/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/fltk
	dev-games/ode
	media-libs/alsa-lib
	virtual/opengl
	virtual/glu
	virtual/glut"
DEPEND="${RDEPEND}
	>=media-libs/plib-1.8.4"

S=${WORKDIR}/${P}/src-${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gentoo.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		-e "s:@GENTOO_BINDIR@:${GAMES_BINDIR}:" \
		-e "s:<FL/:<fltk-$(fltk-config --api-version)/FL/:" \
		Makefile ${PN}.cxx \
		|| die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README

	make_desktop_entry ${PN} Crashtest
	prepgamesdirs
}
