# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/crashtest/crashtest-1.0.ebuild,v 1.2 2007/05/22 02:38:11 nyhm Exp $

inherit eutils games

DESCRIPTION="Educational car crash simulator"
HOMEPAGE="http://stolk.org/crashtest/"
SRC_URI="http://stolk.org/${PN}/${P}.tar.gz"

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
