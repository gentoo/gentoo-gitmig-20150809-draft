# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/pharmacy/pharmacy-0.3-r1.ebuild,v 1.4 2002/06/12 03:23:50 lamer Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gnome Front-End to CVS"
SRC_URI="mirror://sourceforge/pharmacy/${P}.tar.gz"
HOMEPAGE="http://pharmacy.sourceforge.net"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1"

src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die

	make || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO

	insinto /usr/share/doc/pharmacy/index
	doins docs/index/* 
	insinto /usr/share/doc/pharmacy docs/index.sgml
}
