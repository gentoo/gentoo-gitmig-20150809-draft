# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Telnet/Net-Telnet-3.02-r1.ebuild,v 1.3 2002/07/25 04:13:27 seemant Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A Telnet Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/Net/${A}"
SLOT="0"
HOMEPAGE="http://www.cpan.org/modules/by-module/Net/${P}.readme"

SLOT="0"
DEPEND=">=sys-devel/perl-5
        >=dev-perl/libnet-1.0703"

src_compile() {

    perl Makefile.PL
    try make 
   
}

src_install () {
    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc ChangeLog MANIFEST README
}

