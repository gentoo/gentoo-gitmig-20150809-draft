# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Storable/Storable-1.0.7.ebuild,v 1.5 2002/07/25 04:13:27 seemant Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Storable Module"
SRC_URI="http://www.cpan.org/modules/by-module/Storable/${A}"
SLOT="0"
HOMEPAGE="http://www.cpan.org/modules/by-module/Storable/${P}.readme"

SLOT="0"
DEPEND=">=sys-devel/perl-5"

src_compile() {
    perl Makefile.PL
    try make
    try make test
}

src_install () {
    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc ChangeLog MANIFEST README
}



