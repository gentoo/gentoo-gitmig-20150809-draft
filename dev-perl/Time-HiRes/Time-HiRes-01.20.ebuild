# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-HiRes/Time-HiRes-01.20.ebuild,v 1.1 2000/11/06 19:38:34 jerry Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A Precise Time Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/Time/${A}"
HOMEPAGE="http://www.cpan.org/modules/by-module/Time/${P}.readme"

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
