# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SOAP/SOAP-0.25.ebuild,v 1.4 2000/11/04 12:54:30 achim Exp $

P=SOAP-0.25
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Perl Module for SOAP"
SRC_URI="http://cpan.valueclick.com/modules/by-module/SOAP/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/SOAP/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=dev-perl/HTML-Parser-3.13
	>=dev-perl/URI-1.09
	>=dev-perl/XML-Parser-2.29
	>=dev-perl/mod_perl-1.24"
	
src_compile() {

    cd ${S}
    perl Makefile.PL 
    try make
#    try make test

}

src_install () {

    cd ${S}
    try make PREFIX=${D}/usr install
    dodoc Changes README MANIFEST
}




