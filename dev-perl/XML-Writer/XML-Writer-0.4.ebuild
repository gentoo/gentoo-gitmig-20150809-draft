# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Writer/XML-Writer-0.4.ebuild,v 1.5 2001/05/03 16:38:57 achim Exp $

P=XML-Writer-0.4
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="XML Writer Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/XML/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/XML/${P}.readme"

DEPEND=">=sys-devel/perl-5"

src_compile() {

    perl Makefile.PL 
    try make
#    try make test

}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc README MANIFEST Changes
}





