# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pharmacy/pharmacy-0.3-r1.ebuild,v 1.6 2002/07/23 13:28:37 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gnome Front-End to CVS"
SRC_URI="mirror://sourceforge/pharmacy/${P}.tar.gz"
HOMEPAGE="http://pharmacy.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1"

src_compile() {
	econf || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO

	insinto /usr/share/doc/pharmacy/index
	doins docs/index/* 
	insinto /usr/share/doc/pharmacy docs/index.sgml
}
