# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/bonobo/bonobo-1.0.9-r1.ebuild,v 1.1 2001/10/06 10:06:50 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A set of language and system independant CORBA interfaces"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"


RDEPEND=">=gnome-base/oaf-0.6.6-r1
	 >=gnome-base/ORBit-0.5.10-r1
	 >=gnome-base/gnome-print-0.30"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext ) 
	sys-devel/perl
        >=dev-util/xml-i18n-tools-0.8.4"


src_unpack() {
	unpack ${A}
	
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}.patch
	autoconf
	automake
}

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi
  
	# on of the samples in the package need to be regenerated from 
	# the idl files

	rm -f ${S}/samples/bonobo-class/Bonobo_Sample_Echo.h
	rm -f ${S}/samples/bonobo-class/Bonobo_Sample_Echo-*.c

	./configure --host=${CHOST} 					\
		    --prefix=/use					\
	            --sysconfdir=/etc					\
		    ${myconf} || die

	make || die # make -j 4 didn't work
}

src_install() {
	make prefix=${D}/usr sysconfdir=${D}/etc install || die

	dodoc AUTHORS COPYING* ChangeLog README
	dodoc NEWS TODO
}





