# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libnet/libnet-1.0703-r1.ebuild,v 1.4 2000/11/04 12:54:30 achim Exp $

P=libnet-1.0703
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A URI Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/05_Networking_Devices_IPC/Net/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/05_Networking_Devices_IPC/Net/${P}.readme"

DEPEND=">=sys-devel/perl-5"

src_compile() {

    cd ${S}
    cp ${O}/files/libnet.cfg .
    perl Makefile.PL 
    try make 
    try make test
}

src_install () {

    cd ${S}
    try make PREFIX=${D}/usr install
    dodoc ChangeLog README* MANIFEST
    
}









