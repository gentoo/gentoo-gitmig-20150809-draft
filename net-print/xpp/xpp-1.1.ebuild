# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-print/xpp/xpp-1.1.ebuild,v 1.4 2002/07/17 01:42:40 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="X Printing Panel"
SRC_URI="mirror://sourceforge/cups/${P}.tar.gz"
HOMEPAGE="http://cups.sourceforge.net/xpp/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc >=net-print/cups-1.1.14
	>=x11-libs/fltk-1.0.11"

src_compile() {

	econf || die
	make || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc LICENSE ChangeLog README
}

