# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xmille/xmille-2.0.ebuild,v 1.1 2004/01/09 01:43:59 mr_bones_ Exp $

inherit eutils games

S="${WORKDIR}/${PN}-${PV}.orig"
DESCRIPTION="Mille Bournes card game"
SRC_URI="http://ftp.debian.org/debian/pool/main/x/xmille/${PN}_${PV}.orig.tar.gz"

KEYWORDS="x86"
LICENSE="public-domain"
SLOT="0"
IUSE=""

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PV}.patch"
}

src_compile() {
	xmkmf
	emake -j1 || die "emake failed"
}

src_install() {
	dogamesbin xmille || die "dogamesbin failed"
	dodoc CHANGES README || die "dodoc failed"
	newman xmille.man xmille.6 || die "newman failed"
	prepgamesdirs
}
