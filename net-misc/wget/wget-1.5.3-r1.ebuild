# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/wget/wget-1.5.3-r1.ebuild,v 1.6 2001/03/06 05:27:28 achim Exp $

A="${P}.tar.gz wget-new-percentage-3.0.tgz"
S=${WORKDIR}/${P}
DESCRIPTION="Network utility to retrieve files from the WWW"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/wget/${P}.tar.gz
	 ftp://prep.ai.mit.edu/gnu/wget/${P}.tar.gz
	 http://www.biscom.net/~cade/away/projects/wget-new-percentage-3.0.tgz"
HOMEPAGE="http://www.cg.tuwien.ac.at/~prikryl/wget.html"

DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack () {
  unpack ${A}
  cd ${S}/src
  cp ../../wget-new-percentage/wget-new-percentage.c .
  patch retr.c < ../../wget-new-percentage/wget-new-percentage.diff
}
src_compile() {
                           
    try ./configure --prefix=/usr --sysconfdir=/etc/wget --infodir=/usr/share/info --disable-debug 
    try make
}

src_install() {   
                            
    try make prefix=${D}/usr sysconfdir=${D}/etc/wget infodir=${D}/usr/share/info install
	 	
    dodoc AUTHORS COPYING ChangeLog MACHINES MAILING-LIST NEWS README TODO 
    dodoc doc/sample.wgetrc
}


