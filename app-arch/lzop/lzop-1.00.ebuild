# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author George Shapovalov <georges@cco.caltech.edu>
# /space/gentoo/cvsroot/gentoo-x86/dev-libs/gmp/gmp-3.1.1-r1.ebuild,v 1.4 2001/11/24 18:40:50 drobbins Exp

S=${WORKDIR}/${P}
DESCRIPTION="Utility for fast (even reat-time) compression/decompression"
SRC_URI="http://www.oberhumer.com/opensource/lzop/download/${P}.tar.gz"
HOMEPAGE="http://www.oberhumer.com/opensource/lzop/"
DEPEND="virtual/glibc
		dev-libs/lzo"
RDEPEND="virtual/glibc"

src_compile() {                           
	./configure --host=${CHOST}					\
		    --prefix=/usr --disable-shared	
	assert

	make || die
}

src_install() {                               
	make prefix=${D}/usr install || die

	dodoc AUTHORS ChangeLog COPYING* NEWS README THANKS
	dodoc doc/lzop.{txt,ps}
	dohtml doc/*.html
			
}
