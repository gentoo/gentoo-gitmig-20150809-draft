# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libnet/libnet-1.0703-r1.ebuild,v 1.1 2000/08/28 02:36:32 achim Exp $

P=libnet-1.0703
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A URI Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/05_Networking_Devices_IPC/Net/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/05_Networking_Devices_IPC/Net/${P}.readme"


src_compile() {

    cd ${S}
    cp ${O}/files/libnet.cfg .
    perl Makefile.PL $PERLINSTALL
    make 
    make test
}

src_install () {

    cd ${S}
    make install
    prepman
    dodoc ChangeLog README* MANIFEST
    
}









