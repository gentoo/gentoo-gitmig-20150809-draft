# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/ORBit/ORBit-0.5.8.ebuild,v 1.7 2001/08/31 21:40:07 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A high-performance, lightweight CORBA ORB aiming for CORBA 2.2 compliance"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.labs.redhat.com/orbit/"

DEPEND="virtual/glibc 
	nls? ( sys-devel/gettext )
	>=sys-apps/tcp-wrappers-7.6
	>=dev-libs/glib-1.2.8
	>=gnome-base/gnome-env-1.0"

RDEPEND="virtual/glibc 
	>=gnome-base/gnome-env-1.0
	>=dev-libs/glib-1.2.8"


src_compile() {
	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} --prefix=/opt/gnome \
        	    --sysconfdir=/etc/opt/gnome $myconf

	assert "Configure failed."

	make || die "Building failed.  # Doesn't work with -j 4 (hallski)
}

src_install() {
	make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome \
	     install
	assert "Installation failed."

	dosed /opt/gnome/lib/*.la
	dodoc AUTHORS COPYING* ChangeLog README NEWS TODO
	dodoc docs/*.txt docs/IDEA1
	docinto idl

	cd libIDL
	dodoc AUTHORS BUGS COPYING NEWS README*
	docinto popt
	
	cd ../popt
	dodoc CHANGES COPYING README
}




