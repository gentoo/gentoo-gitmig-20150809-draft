# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-tk/perl-tk800-022.ebuild,v 1.5 2001/05/01 18:29:05 achim Exp $

P=Tk800.022
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Perl Module for Tk"
SRC_URI="http://cpan.valueclick.com/modules/by-module/Tk/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/Tk/${P}.readme"

DEPEND=">=sys-devel/perl-5
	virtual/x11"

src_compile() {

    cd ${S}
    perl Makefile.PL 
    try make
#    try make test

}

src_install () {

    cd ${S}
    try make PREFIX=${D}/usr install
    dodoc Change.log Changes COPYING README* MANIFEST*
    dodoc ToDo VERSIONS
}





