# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SOAP/SOAP-0.28.ebuild,v 1.1 2001/02/16 20:05:58 achim Exp $

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

    perl Makefile.PL 
    try make
#    try make test

}

src_install () {

    try make PREFIX=${D}/usr install
    dodoc Changes README MANIFEST
}




