# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xmille/xmille-2.0-r1.ebuild,v 1.4 2004/11/11 00:55:08 josejx Exp $

inherit eutils games

DEB_PATCH_VER="10"
DESCRIPTION="Mille Bournes card game"
HOMEPAGE=""
SRC_URI="mirror://debian/pool/main/x/xmille/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/x/xmille/${PN}_${PV}-${DEB_PATCH_VER}.diff.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/x11"

S="${WORKDIR}/${PN}-${PV}.orig"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${WORKDIR}/${PN}_${PV}-${DEB_PATCH_VER}.diff"
}

src_compile() {
	xmkmf
	emake -j1 || die "emake failed"
}

src_install() {
	dogamesbin xmille || die "dogamesbin failed"
	dodoc CHANGES README
	newman xmille.man xmille.6
	prepgamesdirs
}
