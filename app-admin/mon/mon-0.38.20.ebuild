# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-admin/mon/mon-0.38.20.ebuild,v 1.1 2000/12/25 16:26:17 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Highly configurable service monitoring daemon"
SRC_URI="ftp://ftp.kernel.org/pub/software/admin/mon/mon-0.38.20.tar.bz2"
HOMEPAGE="http://www.kernel.org/software/mon/"


src_compile() {

    cd ${S}/mon.d
    try make

}

src_install () {

    cd ${S}

    dosbin mon clients/mon*

    insinto /etc/mon
    doins etc/*

    insinto /usr/lib/mon/utils
    doins utils/*

    insinto /usr/lib/mon/alert.d
    doins alert.d/*
  
    insinto /usr/lib/mon/mon.d
    doins mon.d/*.monitor
    insopts -g uucp -m 02555 mon.d/*.wrap
	
    dodoc CHANGES COPYING CREDITS KNOWN-PROBLEMS
    dodoc mon.lsm README TODO VERSION
    doman doc/*.1
    docinto txt
    dodoc doc/README*
}


