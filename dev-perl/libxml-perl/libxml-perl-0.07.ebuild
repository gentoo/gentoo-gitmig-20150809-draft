# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libxml-perl/libxml-perl-0.07.ebuild,v 1.6 2001/05/03 16:38:58 achim Exp $

P=libxml-perl-0.07
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Collection of Perl modules for working with XML"
SRC_URI="http://cpan.valueclick.com/modules/by-module/XML/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/XML/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=dev-perl/XML-Parser-2.29"

src_compile() {

    perl Makefile.PL 
    try make
    make test

}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc README ChangeLog Changes
}





