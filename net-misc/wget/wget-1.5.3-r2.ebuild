# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/wget/wget-1.5.3-r2.ebuild,v 1.1 2001/04/30 12:42:20 achim Exp $

A="${P}.tar.gz wget-new-percentage-3.0.tgz"
S=${WORKDIR}/${P}
DESCRIPTION="Network utility to retrieve files from the WWW"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/wget/${P}.tar.gz
	 ftp://prep.ai.mit.edu/gnu/wget/${P}.tar.gz
	 http://www.biscom.net/~cade/away/projects/wget-new-percentage-3.0.tgz"
HOMEPAGE="http://www.cg.tuwien.ac.at/~prikryl/wget.html"

DEPEND=">=sys-libs/glibc-2.1.3
	nls? ( sys-devel/gettext )"

src_unpack () {
  unpack ${A}
  cd ${S}/src
  cp ../../wget-new-percentage/wget-new-percentage.c .
  patch retr.c < ../../wget-new-percentage/wget-new-percentage.diff
}
src_compile() {
    local myconf
    if [ -z "`use nls`" ] ; then
	myconf="--disable-nls"
    fi                       
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
        dobin wget
    else                      
        try make prefix=${D}/usr sysconfdir=${D}/etc/wget infodir=${D}/usr/share/info install
	 	
        dodoc AUTHORS COPYING ChangeLog MACHINES MAILING-LIST NEWS README TODO 
        dodoc doc/sample.wgetrc
    fi
}


