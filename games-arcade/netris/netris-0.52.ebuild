# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/netris/netris-0.52.ebuild,v 1.2 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="Classic networked version of T*tris"
HOMEPAGE="http://www.netris.org/"
SRC_URI="ftp://ftp.netris.org/pub/netris/${P}.tar.gz
	http://ftp.debian.org/debian/pool/main/n/netris/netris_${PV}-1.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	epatch netris_${PV}-1.diff
}

src_compile() {
	./Configure --copt "${CFLAGS}" || die "Configure failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin netris sr
	dodoc FAQ README robot_desc
	prepgamesdirs
}
