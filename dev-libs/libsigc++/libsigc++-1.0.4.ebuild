# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigc++/libsigc++-1.0.4.ebuild,v 1.2 2001/11/10 12:05:20 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The GLib library of C routines"
SRC_URI="http://download.sourceforge.net/libsigc/${P}.tar.gz"
HOMEPAGE="http://libsigc.sourceforge.net/"

DEPEND="virtual/glibc"

src_compile() {

	local myconf
    
	if [ "${DEBUG}" ]
	then
		myconf="--enable-debug=yes"
	else
		myconf="--enable-debug=no"
	fi
    
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
	  	    --infodir=/usr/share/info				\
		    --mandir=/usr/share/man				\
		    ${myconf} || die
	
	emake || die
}

src_install() {
	make DESTDIR=${D}						\
	     install || die
    
	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS
}
