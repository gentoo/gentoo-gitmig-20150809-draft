# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xgammon/xgammon-0.98.ebuild,v 1.2 2003/11/04 22:18:22 weeve Exp $

inherit eutils

S=${WORKDIR}/${P}a
DESCRIPTION="very nice backgammon game for X"
SRC_URI="http://fawn.unibw-hamburg.de/steuer/xgammon/Downloads/${P}a.tar.gz"
HOMEPAGE="http://fawn.unibw-hamburg.de/steuer/xgammon/xgammon.html"

KEYWORDS="x86 ppc ~sparc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/xgammon-0.98-broken.patch
	epatch ${FILESDIR}/xgammon-0.98-config.patch
}

src_compile() {
	xmkmf || die "xmkmf died"
	env PATH="${PATH}:." emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
