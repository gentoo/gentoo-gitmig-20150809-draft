# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-String/IO-String-1.01.ebuild,v 1.1 2001/03/16 17:13:26 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Image-Info Module"
SRC_URI="http://www.cpan.org/modules/by-module/IO/${A}"
HOMEPAGE="http://www.cpan.org/modules/by-module/IO/${P}.readme"

DEPEND=">=sys-devel/perl-5"


src_compile() {
    perl Makefile.PL
    try make
    try make test
}

src_install () {
    try make PREFIX=${D}/usr install
    dodoc Changes MANIFEST README 
}



