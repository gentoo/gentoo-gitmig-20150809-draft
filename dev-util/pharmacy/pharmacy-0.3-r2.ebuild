# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pharmacy/pharmacy-0.3-r2.ebuild,v 1.9 2005/08/07 13:00:36 hansmi Exp $

DESCRIPTION="Gnome Front-End to CVS"
SRC_URI="mirror://sourceforge/pharmacy/${P}.tar.gz"
HOMEPAGE="http://pharmacy.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc sparc x86"
IUSE=""

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1"

src_compile() {
	econf || die
	make || die
}

src_install () {
	# install script is b0rked (bug #8366)
	make install prefix=${D}/usr datadir=${D}/usr/share || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO

	insinto /usr/share/doc/pharmacy/index
	doins docs/index/*
	insinto /usr/share/doc/pharmacy docs/index.sgml
}
