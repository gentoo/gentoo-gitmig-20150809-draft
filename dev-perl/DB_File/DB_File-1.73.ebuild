# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DB_File/DB_File-1.73.ebuild,v 1.3 2001/01/19 02:36:51 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Berkeley DB Support Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/DB_File/${A}"
HOMEPAGE="http://www.cpan.org/modules/by-module/DB_File/${P}.readme"

DEPEND=">=sys-devel/perl-5
        >=sys-libs/db-1.85"
    

src_compile() {
    cp ${FILESDIR}/config.in .
    perl Makefile.PL
    try make 
    try make test
}

src_install () {
    cd ${S}
    try make PREFIX=${D}/usr install
    dodoc Changes MANIFEST README
}
