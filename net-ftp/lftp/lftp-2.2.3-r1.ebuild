# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/lftp/lftp-2.2.3-r1.ebuild,v 1.2 2000/08/16 04:38:14 drobbins Exp $

P=lftp-2.2.3
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Groovy little ftp client"
SRC_URI="ftp://ftp.yars.free.net/pub/software/unix/net/ftp/client/lftp/lftp-2.2.3.tar.bz2"
HOMEPAGE="http://ftp.yars.free.net/projects/lftp/"

src_unpack () {
    unpack ${A}
}

src_compile() {                           
    export CFLAGS="-fno-exceptions -fno-rtti ${CFLAGS}"
    export CXXFLAGS="-fno-exceptions -fno-rtti ${CXXFLAGS}"
    ./configure --prefix=/usr --sysconfdir=/etc/lftp --with-catgets --with-modules
    make
}

src_install() {
	cd ${S}
	make prefix=${D}/usr sysconfdir=${D}/etc/lftp install
	prepman
	dodoc BUGS COPYING ChangeLog FAQ FEATURES MIRRORS NEWS
	dodoc README* THANKS TODO
	
}



