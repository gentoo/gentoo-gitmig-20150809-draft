# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MLDBM/MLDBM-2.00.ebuild,v 1.3 2001/05/03 16:38:57 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A multidimensional/tied hash Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-authors/id/GSAR/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-authors/id/GSAR/${A}.readme"

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
