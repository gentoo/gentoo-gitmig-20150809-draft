# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libghttp/libghttp-1.0.9-r1.ebuild,v 1.3 2002/07/11 06:30:26 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libghttp"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"

HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc"

src_compile() {
	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
	  	    --localstatedir=/var/lib
	assert

	emake || die
}

src_install() {                               
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS TODO

	docinto html
	dodoc doc/ghttp.html
}
