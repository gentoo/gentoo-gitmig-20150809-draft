# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libical-moz/libical-moz-0.23.ebuild,v 1.8 2003/07/14 15:11:46 agriffis Exp $

S=${WORKDIR}/libical-0.23-moz
DESCRIPTION="libical is used by the mozilla calendar component"
SRC_URI="http://www.oeone.com/files/libical-${PV}-moz.tar.gz"
HOMEPAGE="http://www.mozilla.org/projects/calendar/installation.html"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="MPL-1.1 | LGPL-2"
KEYWORDS="x86 sparc ~alpha"

src_compile() {

	cd ${S}
	./autogen.sh --prefix=/usr --disable-python-bindings || die
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog LICENSE NEWS README TEST THANKS TODO
}
