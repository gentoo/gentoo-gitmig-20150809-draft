# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/divx4linux/divx4linux-20011025.ebuild,v 1.3 2002/07/11 06:30:38 drobbins Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Binary release of DivX Codec 4.0"
SRC_URI="http://avifile.sourceforge.net/${P}.tgz"
HOMEPAGE="http://www.divx.com/"

DEPEND="virtual/glibc"


src_install () {
	
	dodir /usr/{lib,include}

	dolib.so *.so

	insinto /usr/include
	doins *.h

	dodoc RELNOTES.linux license.txt
	cp -a 'Codec Core Interface.txt' ${D}/usr/share/doc/${P}/ 
}
