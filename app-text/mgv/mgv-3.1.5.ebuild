# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /home/cvsroot/gentoo-x86/skel.build,v 1.2 2001/02/15 18:17:31 achim Exp
# $Header: /var/cvsroot/gentoo-x86/app-text/mgv/mgv-3.1.5.ebuild,v 1.16 2003/09/05 22:37:22 msterret Exp $

inherit eutils

IUSE=""

DESCRIPTION="Motif PostScript viewer loosely based on Ghostview"
SRC_URI="http://www.trends.net/~mu/srcs/${P}.tar.gz"
HOMEPAGE="http://www.trends.net/~mu/mgv.html"

KEYWORDS="x86 sparc"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=app-text/ghostscript-3.33
	virtual/motif"

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
