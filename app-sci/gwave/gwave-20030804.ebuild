# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gwave/gwave-20030804.ebuild,v 1.3 2004/04/07 19:44:50 vapier Exp $

inherit eutils

DESCRIPTION="A waveform viewer analog data, such as SPICE simulations."
HOMEPAGE="http://www.geda.seul.org/tools/gwave/"
SRC_URI="http://www.geda.seul.org/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=x11-libs/gtk+-1.2
	>=dev-util/guile-1.6
	>=x11-libs/guile-gtk-1.2.0.31"

src_compile() {
	epatch ${FILESDIR}/gwave-${PV}.gcc33.patch.bz2

	econf || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	rm -f doc/Makefile* *.1
	dodoc AUTHORS INSTALL NEWS README TODO doc/*
}
