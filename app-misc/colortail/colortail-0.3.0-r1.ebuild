# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/colortail/colortail-0.3.0-r1.ebuild,v 1.1 2002/05/14 21:27:03 g2boojum Exp $

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
	dodir /usr/bin/wrappers
	dosym /usr/bin/colortail /usr/bin/wrappers/tail
}

pkg_postinst() {
	if grep /usr/bin/wrappers /etc/profile > /dev/null
	then
		echo "/etc/profile already updated for wrappers"
	else
		echo "Add this to the end of your ${ROOT}etc/profile:"
		echo
		echo "#Put /usr/bin/wrappers in path before /usr/bin"
		echo 'export PATH=/usr/bin/wrappers:${PATH}'
	fi
}


  
