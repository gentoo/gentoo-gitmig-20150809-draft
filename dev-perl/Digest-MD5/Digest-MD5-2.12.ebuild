# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-MD5/Digest-MD5-2.12.ebuild,v 1.1 2000/10/05 00:12:59 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A URI Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/14_Security_and_Encryption/Digest/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/14_Security_and_Encryption/Digest/${P}.readme"


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
    dodoc Changes MANIFEST README rfc*.txt

}








