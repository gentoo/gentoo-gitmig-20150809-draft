# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/bonobo/bonobo-1.0.19.ebuild,v 1.2 2002/07/11 06:30:25 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A set of language and system independant CORBA interfaces"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"


RDEPEND=">=gnome-base/oaf-0.6.7
	 >=gnome-base/ORBit-0.5.12
	 >=gnome-base/gnome-print-0.30"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext ) 
	sys-devel/perl
        >=dev-util/intltool-0.11"

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi
  
	CFLAGS="${CFLAGS} `gnome-config --cflags print`"

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
	            --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    ${myconf} || die

	make || die # make -j 4 didn't work
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	chmod 644 ${D}/usr/lib/pkgconfig/libefs.pc

	dodoc AUTHORS COPYING* ChangeLog README
	dodoc NEWS TODO
}





