# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PlRPC/PlRPC-0.2012.ebuild,v 1.1 2001/01/24 07:52:00 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl RPC Module"
SRC_URI="http://www.cpan.org/modules/by-module/RPC/${A}"
HOMEPAGE="http://www.cpan.org/modules/by-module/RPC/${P}.readme"

DEPEND=">=dev-perl/Storable-1.0.7
        >=dev-perl/Net-Daemon-0.34
        >=sys-devel/perl-5"

src_compile() {
    cd ${S}
    perl Makefile.PL
    try make
}

src_install () {
    cd ${S}
    try make PREFIX=${D}/usr install
    dodoc ChangeLog MANIFEST README
}



