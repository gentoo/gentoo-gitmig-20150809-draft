# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/wget/wget-1.5.3-r1.ebuild,v 1.2 2000/08/16 04:38:20 drobbins Exp $

P=wget-1.5.3    
A="${P}.tar.gz wget-new-percentage-3.0.tgz"
S=${WORKDIR}/${P}
DESCRIPTION="Network utility to retrieve files from the WWW"
SRC_URI="ftp://prep.ai.mit.edu/gnu/wget/${P}.tar.gz
	 http://www.biscom.net/~cade/away/projects/wget-new-percentage-3.0.tgz"
HOMEPAGE="http://www.cg.tuwien.ac.at/~prikryl/wget.html"

src_unpack () {
  unpack ${A}
  cd ${S}/src
  cp ../../wget-new-percentage/wget-new-percentage.c .
  patch retr.c < ../../wget-new-percentage/wget-new-percentage.diff
}
src_compile() {                           
    ./configure --prefix=/usr --sysconfdir=/etc/wget --disable-debug 
    make
}

src_install() {                               
    cd ${S}
    make prefix=${D}/usr sysconfdir=${D}/etc/wget install	 	
    prepinfo
    dodoc AUTHORS COPYING ChangeLog MACHINES MAILING-LIST NEWS README TODO 
    dodoc doc/sample.wgetrc
}


