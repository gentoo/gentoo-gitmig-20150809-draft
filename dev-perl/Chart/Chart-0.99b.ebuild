# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Chart/Chart-0.99b.ebuild,v 1.2 2001/01/24 07:56:52 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Chart Module"
SRC_URI="http://www.cpan.org/modules/by-module/Chart/${A}"
HOMEPAGE="http://www.cpan.org/modules/by-module/Chart/${P}.readme"

DEPEND=">=dev-perl/GD-1.19
	>=sys-devel/perl-5"

src_compile() {
    cd ${S}
    perl Makefile.PL
    try make
    try make test
}

src_install () {
    cd ${S}
    try make PREFIX=${D}/usr install
    dodoc TODO MANIFEST README
}



