# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/divx4linux/divx4linux-20011025.ebuild,v 1.2 2002/05/23 06:50:13 seemant Exp $

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
