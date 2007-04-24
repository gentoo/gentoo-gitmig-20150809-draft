# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/netris/netris-0.52.ebuild,v 1.13 2007/04/24 14:49:27 drizzt Exp $

inherit eutils games

DESCRIPTION="Classic networked version of T*tris"
HOMEPAGE="http://www.netris.org/"
SRC_URI="ftp://ftp.netris.org/pub/netris/${P}.tar.gz
	mirror://debian/pool/main/n/netris/netris_${PV}-6.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 mips ppc ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	epatch netris_${PV}-6.diff
}

src_compile() {
	./Configure --copt "${CFLAGS}" || die "Configure failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin netris sr || die
	dodoc FAQ README robot_desc
	prepgamesdirs
}
