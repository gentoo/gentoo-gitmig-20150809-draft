# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# Maintainer: foser <foser@sesmar.eu.org>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/freesci/freesci-0.3.3.ebuild,v 1.1 2002/02/12 19:51:51 verwilst Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Sierra script interpreter for your old Sierra adventures"
SRC_URI="http://darmstadt.gmd.de/~jameson/${P}.tar.bz2"
HOMEPAGE="http://freesci.linuxgames.com/"

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


