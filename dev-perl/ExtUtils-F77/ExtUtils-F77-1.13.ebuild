# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-F77/ExtUtils-F77-1.13.ebuild,v 1.1 2000/08/28 10:37:27 achim Exp $

P=ExtUtils-F77-1.13
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="F77 Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/ExtUtils/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/ExtUtils/${P}.readme"


src_compile() {

    cd ${S}
    perl Makefile.PL $PERLINSTALL
    make
    make test

}

src_install () {

    cd ${S}
    make install
    prepman
    dodoc CHANGES README MANIFEST
}





