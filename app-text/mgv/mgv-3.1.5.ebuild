# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mgv/mgv-3.1.5.ebuild,v 1.20 2004/10/03 21:12:48 swegener Exp $

inherit eutils

IUSE=""

DESCRIPTION="Motif PostScript viewer loosely based on Ghostview"
SRC_URI="http://www.trends.net/~mu/srcs/${P}.tar.gz"
HOMEPAGE="http://www.trends.net/~mu/mgv.html"

KEYWORDS="x86 sparc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/ghostscript
	x11-libs/openmotif"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-stderr.patch || die
}

src_compile() {
	econf || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
	dohtml doc/*.sgml
}
