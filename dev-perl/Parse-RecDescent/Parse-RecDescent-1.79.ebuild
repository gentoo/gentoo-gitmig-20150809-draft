# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-RecDescent/Parse-RecDescent-1.79.ebuild,v 1.2 2000/09/15 20:08:49 drobbins Exp $

P=Parse-RecDescent-1.79
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/Parse/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/Parse/${P}.readme"


src_compile() {

    cd ${S}
    perl Makefile.PL $PERLINSTALL
    try make
    try make test

}

src_install () {

    cd ${S}
    try make install
    prepman
    dodoc Changes README MANIFEST
    docinto html
    dodoc tutorial/*
}






