# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MLDBM/MLDBM-2.00.ebuild,v 1.5 2002/07/25 04:13:26 seemant Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A multidimensional/tied hash Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-authors/id/GSAR/${A}"
SLOT="0"
HOMEPAGE="http://cpan.valueclick.com/modules/by-authors/id/GSAR/${A}.readme"

SLOT="0"
DEPEND=">=sys-devel/perl-5"

src_compile() {
    perl Makefile.PL
    try make 
    try make test
}

src_install () {
    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc Changes MANIFEST README
}
