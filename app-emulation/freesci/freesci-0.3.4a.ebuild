# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/freesci/freesci-0.3.4a.ebuild,v 1.1 2003/05/12 20:22:59 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Sierra script interpreter for your old Sierra adventures"
SRC_URI="http://savannah.nongnu.org/download/freesci/stable.pkg/${PV}/${P}.tar.bz2"
HOMEPAGE="http://freesci.linuxgames.com/"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND="virtual/x11"

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die

}

src_install () {

	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README README.Unix THANKS TODO

}
