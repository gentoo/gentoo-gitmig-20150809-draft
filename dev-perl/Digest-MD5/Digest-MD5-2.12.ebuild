# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-MD5/Digest-MD5-2.12.ebuild,v 1.7 2001/05/03 16:38:57 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A URI Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/14_Security_and_Encryption/Digest/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/14_Security_and_Encryption/Digest/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=sys-libs/glibc-2.1.3"

src_compile() {

    perl Makefile.PL 
    try make 
    try make test
}

src_install () {

    make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc Changes MANIFEST README rfc*.txt

}








