# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-HiRes/Time-HiRes-01.20.ebuild,v 1.6 2002/07/25 04:13:27 seemant Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Precise Time Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/Time/${A}"
SLOT="0"
HOMEPAGE="http://www.cpan.org/modules/by-module/Time/${P}.readme"

SLOT="0"
DEPEND=">=sys-devel/perl-5 virtual/glibc"

src_compile() {
    perl Makefile.PL
    try make 
    try make test
}

src_install () {
    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc Changes MANIFEST README
}
