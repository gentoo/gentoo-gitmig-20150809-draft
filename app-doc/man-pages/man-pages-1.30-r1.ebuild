# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/man-pages/man-pages-1.30-r1.ebuild,v 1.2 2000/08/16 04:37:53 drobbins Exp $

P=man-pages-1.30
A="${P}.tar.gz netman-cvs.tar.gz man2.tar.gz"
#A0=man-pages-1.23-spell.patch
S=${WORKDIR}/${P}
DESCRIPTION="A somewhat comprehensive collection of Linux man pages"
SRC_URI="ftp://ftp.win.tue.nl/pub/linux-local/manpages/man-pages-1.30.tar.gz"

src_compile() {                           
   echo
}

src_unpack() {
    unpack ${P}.tar.gz
    cd ${S}
    tar xzf ${O}/files/netman-cvs.tar.gz
    tar xzf ${O}/files/man2.tar.gz
    for x in 2 3 4
    do
	mv *.$x man$x
    done
}

src_install() {                               
	for x in 1 2 3 4 5 6 7 8
	do
		doman man$x/*.[1-9]
	done
}





