# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/blokish/blokish-0.9.3.ebuild,v 1.2 2006/11/05 18:46:43 peper Exp $

inherit eutils games

MY_P="${PN}_src_v${PV}"
DESCRIPTION="Open source clone of the four-player board game Blokus"
HOMEPAGE="http://sourceforge.net/projects/blokish/"
SRC_URI="mirror://sourceforge/blokish/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="=x11-libs/wxGTK-2.6*
	virtual/opengl"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s:wx-config:wx-config-2.6:" \
		configure makefile.in \
		|| die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	dohtml docs/*
	prepgamesdirs
}
