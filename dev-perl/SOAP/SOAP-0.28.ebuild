# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SOAP/SOAP-0.28.ebuild,v 1.5 2002/07/25 04:13:27 seemant Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Perl Module for SOAP"
SRC_URI="http://cpan.valueclick.com/modules/by-module/SOAP/${A}"
SLOT="0"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/SOAP/${P}.readme"

SLOT="0"
DEPEND=">=sys-devel/perl-5
	>=dev-perl/XML-Parser-2.29
	>=dev-perl/mod_perl-1.24"
	
src_compile() {

    perl Makefile.PL 
    try make
#    try make test

}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc Changes README MANIFEST
}




