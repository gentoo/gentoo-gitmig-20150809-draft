# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-tk/perl-tk800-022.ebuild,v 1.1 2000/08/29 19:47:24 achim Exp $

P=Tk800.022
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Perl Module for Tk"
SRC_URI="http://cpan.valueclick.com/modules/by-module/Tk/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/Tk/${P}.readme"


src_compile() {

    cd ${S}
    perl Makefile.PL $PERLINSTALL
    make
#    make test

}

src_install () {

    cd ${S}
    make install
    prepman
    dodoc Change.log Changes COPYING README* MANIFEST*
    dodoc ToDo VERSIONS
}





