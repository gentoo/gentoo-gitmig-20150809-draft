# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libghttp/libghttp-1.0.9-r1.ebuild,v 1.10 2003/09/06 23:51:37 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libghttp"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"

HOMEPAGE="http://www.gnome.org/"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc "
SLOT="0"

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
