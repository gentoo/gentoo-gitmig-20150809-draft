# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/colortail/colortail-0.3.0.ebuild,v 1.2 2002/07/11 06:30:16 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Colortail custom colors your log files and works like tail"
SRC_URI="http://www.student.hk-r.se/~pt98jan/colortail-0.3.0.tar.gz"
HOMEPAGE="http://www.student.hk-r.se/~pt98jan/colortail.html"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/usr --host=${CHOST}
        make || die
}
 
src_install()  {
	
	make DESTDIR=${D} install || die
	dodoc README example-conf/conf*
}
  
