# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gwave/gwave-20020122.ebuild,v 1.5 2004/04/25 22:49:46 agriffis Exp $

DESCRIPTION="A waveform viewer analog data, such as spice simulations"
HOMEPAGE="http://www.geda.seul.org/tools/gwave/"
SRC_URI="http://www.geda.seul.org/dist/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

DEPEND="x11-libs/gtk+
	dev-util/guile
	x11-libs/guile-gtk"

src_compile() {
	econf || die "econf failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	rm -f doc/Makefile* *.1
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO doc/*
}
