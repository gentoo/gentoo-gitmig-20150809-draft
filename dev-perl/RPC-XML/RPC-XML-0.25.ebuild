# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RPC-XML/RPC-XML-0.25.ebuild,v 1.3 2001/07/10 03:17:07 achim Exp $

A=${PN}-${PV}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A  Perl extension interface to James Clark's XML parser, expat."
SRC_URI="http://cpan.valueclick.com/modules/by-module/RPC/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/RPC/${PN}.${PV}.readme"

DEPEND=">=sys-devel/perl-5 dev-perl/XML-Parser dev-perl/mod_perl"

src_compile() {

    perl Makefile.PL 
    try make 
    try make test
}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc Changes MANIFEST README 

}










