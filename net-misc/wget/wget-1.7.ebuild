# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/wget/wget-1.7.ebuild,v 1.1 2001/06/05 19:43:20 achim Exp $

A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Network utility to retrieve files from the WWW"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/wget/${P}.tar.gz
	 ftp://prep.ai.mit.edu/gnu/wget/${P}.tar.gz"
HOMEPAGE="http://www.cg.tuwien.ac.at/~prikryl/wget.html"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )
	"

src_compile() {
    local myconf
    if [ -z "`use nls`" ] ; then
	myconf="--disable-nls"
    fi                      
#    if [ "`use ssl`" ] ; then
#	myconf="$myconf --with-ssl=/usr"
#    fi 
    if [ -z "$DEBUG" ] ; then
	myconf="$myconf --disable-debug"
    fi
    try ./configure --prefix=/usr --sysconfdir=/etc/wget --infodir=/usr/share/info $myconf
    if [ "`use static`" ] ; then
       try make -e LDFLAGS=\"--static\"
    else
       try make
    fi
}

src_install() {   
      
    if [ "`use build`" ] ; then
        dobin src/wget
    else                      
        try make prefix=${D}/usr sysconfdir=${D}/etc/wget infodir=${D}/usr/share/info install
	 	
        dodoc AUTHORS COPYING ChangeLog MACHINES MAILING-LIST NEWS README TODO 
        dodoc doc/sample.wgetrc
    fi
}


