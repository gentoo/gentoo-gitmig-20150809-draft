# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/ORBit/ORBit-0.5.10-r1.ebuild,v 1.2 2001/10/07 22:15:58 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A high-performance, lightweight CORBA ORB aiming for CORBA 2.2 compliance"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.labs.redhat.com/orbit/"

DEPEND="virtual/glibc 
	nls? ( sys-devel/gettext )
	>=sys-apps/tcp-wrappers-7.6
	>=dev-libs/glib-1.2.8"

RDEPEND="virtual/glibc 
	>=dev-libs/glib-1.2.8"


src_compile() {
	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
        	    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    $myconf || die

	make || die # Doesn't work with -j 4 (hallski)
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
    	     install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS TODO
	dodoc docs/*.txt docs/IDEA1

	docinto idl
	cd libIDL
	dodoc AUTHORS BUGS COPYING NEWS README*

	docinto popt
	cd ../popt
	dodoc CHANGES COPYING README
}



