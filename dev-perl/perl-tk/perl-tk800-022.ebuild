# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-tk/perl-tk800-022.ebuild,v 1.6 2001/05/03 16:38:58 achim Exp $

P=Tk800.022
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Perl Module for Tk"
SRC_URI="http://cpan.valueclick.com/modules/by-module/Tk/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/Tk/${P}.readme"

DEPEND=">=sys-devel/perl-5
	virtual/x11"

src_compile() {

    perl Makefile.PL 
    try make
#    try make test

}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 \
	  INSTALLMAN1DIR=${D}/usr/share/man/man1 install
    dodoc Change.log Changes COPYING README* MANIFEST*
    dodoc ToDo VERSIONS
}





