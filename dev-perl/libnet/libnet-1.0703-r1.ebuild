# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libnet/libnet-1.0703-r1.ebuild,v 1.7 2001/11/10 00:14:00 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A URI Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/05_Networking_Devices_IPC/Net/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/05_Networking_Devices_IPC/Net/${P}.readme"

DEPEND=">=sys-devel/perl-5"

src_compile() {
	cp ${O}/files/libnet.cfg .
	perl Makefile.PL 
	make || die
#    try make test
}

src_install () {
	make PREFIX=${D}/usr install || die

	dodoc ChangeLog README* MANIFEST
}









