# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-MD5/Digest-MD5-2.12.ebuild,v 1.3 2000/11/04 12:54:30 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A URI Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/14_Security_and_Encryption/Digest/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/14_Security_and_Encryption/Digest/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=sys-libs/glibc-2.1.3"

src_compile() {

    cd ${S}
    echo $PERLINSTALL
    perl Makefile.PL 
    try make 
    try make test
}

src_install () {

    cd ${S}
    make PREFIX=${D}/usr install
    prepman
    dodoc Changes MANIFEST README rfc*.txt

}








