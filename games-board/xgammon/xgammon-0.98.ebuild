# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xgammon/xgammon-0.98.ebuild,v 1.3 2004/02/29 10:15:56 vapier Exp $

inherit eutils

S=${WORKDIR}/${P}a
DESCRIPTION="very nice backgammon game for X"
HOMEPAGE="http://fawn.unibw-hamburg.de/steuer/xgammon/xgammon.html"
SRC_URI="http://fawn.unibw-hamburg.de/steuer/xgammon/Downloads/${P}a.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"
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
