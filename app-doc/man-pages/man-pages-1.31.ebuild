# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/man-pages/man-pages-1.31.ebuild,v 1.3 2000/11/01 04:44:11 achim Exp $

P=man-pages-1.31
A="${P}.tar.gz netman-20000610.tgz"
S=${WORKDIR}/${P}
DESCRIPTION="A somewhat comprehensive collection of Linux man pages"

SRC_URI="ftp://ftp.kernel.org/pub/linux/docs/manpages/man-pages-1.31.tar.gz
	 ftp://ftp.de.kernel.org/pub/linux/docs/manpages/man-pages-1.31.tar.gz
	 ftp://ftp.uk.kernel.org/pub/linux/docs/manpages/man-pages-1.31.tar.gz 
	 ftp://ftp.suse.com/pub/people/ak/netman/netman-20000610.tgz"

DEPEND=""

src_compile() {                           
   echo
}

src_unpack() {
    unpack ${P}.tar.gz
    cd ${S}
    unpack netman-20000610.tgz
    tar xzf ${O}/files/man2.tar.gz
    for x in 2 3 7
    do
	mv netman/*.$x man$x
    done
}

src_install() {                               
	for x in 1 2 3 4 5 6 7 8
	do
		doman man$x/*.[1-9]
	done
	dodoc man-pages-1.31.Announce README
	docinto netman
	dodoc netman/FIXME netman/README
}








