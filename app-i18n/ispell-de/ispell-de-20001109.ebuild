# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ispell-de/ispell-de-20001109.ebuild,v 1.1 2001/02/08 17:55:02 achim Exp $

P=igerman98-${PV}
S=${WORKDIR}/${P}
DESCRIPTION="A german dictionary for ispell"
SRC_URI="http://www.suse.de/~bjacke/igerman98/dict/${P}.tar.bz2"
HOMEPAGE="http://www.suse.de/~bjacke/igerman98/"


src_compile() {

    try make

}

src_install () {

    insinto /usr/lib/ispell
    doins german.aff german.hash
 
    dodoc Documentation/*

}

