# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MLDBM/MLDBM-2.00.ebuild,v 1.1 2000/11/06 19:26:01 jerry Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A multidimensional/tied hash Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-authors/id/GSAR/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-authors/id/GSAR/${A}.readme"

DEPEND=">=sys-devel/perl-5"

src_compile() {
    cd ${S}
    perl Makefile.PL
    try make 
    try make test
}

src_install () {
    cd ${S}
    try make PREFIX=${D}/usr install
    dodoc Changes MANIFEST README
}
