# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PlRPC/PlRPC-0.2014.ebuild,v 1.2 2001/05/03 16:38:57 achim Exp $

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
    perl Makefile.PL
    try make
}

src_install () {
    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc ChangeLog MANIFEST README
}



