# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Storable/Storable-1.0.7.ebuild,v 1.2 2001/03/12 10:52:49 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Storable Module"
SRC_URI="http://www.cpan.org/modules/by-module/Storable/${A}"
HOMEPAGE="http://www.cpan.org/modules/by-module/Storable/${P}.readme"

DEPEND=">=sys-devel/perl-5"

src_compile() {
    perl Makefile.PL
    try make
    try make test
}

src_install () {
    try make PREFIX=${D}/usr install
    dodoc ChangeLog MANIFEST README
}



