# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/wget/wget-1.7-r1.ebuild,v 1.5 2001/08/19 05:43:20 drobbins Exp $

A="${P}.tar.gz wget-new-percentage-1.7-20010606.diff"
S=${WORKDIR}/${P}
DESCRIPTION="Network utility to retrieve files from the WWW"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/wget/${P}.tar.gz
	 ftp://prep.ai.mit.edu/gnu/wget/${P}.tar.gz
         http://www.biscom.net/~cade/away/wget-new-percentage/wget-new-percentage-1.7-20010606.diff"
HOMEPAGE="http://www.cg.tuwien.ac.at/~prikryl/wget.html"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )"

RDEPEND="virtual/glibc"

src_unpack() {
    unpack ${P}.tar.gz
    cd ${S}/src
    patch -p0 < ${DISTDIR}/wget-new-percentage-1.7-20010606.diff
}

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
    try ./configure --prefix=/usr --sysconfdir=/etc/wget \
	--infodir=/usr/share/info --mandir=usr/share/man $myconf
    if [ "`use static`" ] ; then
       try make -e LDFLAGS="--static"
    else
       try make
    fi
}

src_install() {   
	if [ "`use build`" ] || [ "`use bootcd`" ] ; then
        insinto /usr
		dobin ${S}/src/wget	
    	return
	fi                      
			
	try make prefix=${D}/usr sysconfdir=${D}/etc/wget \
		mandir=${D}/usr/share/man infodir=${D}/usr/share/info install
	dodoc AUTHORS COPYING ChangeLog MACHINES MAILING-LIST NEWS README TODO 
	dodoc doc/sample.wgetrc
}


