# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-ShowTable/Data-ShowTable-3.3.ebuild,v 1.2 2001/05/03 16:38:57 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl ShowTable Module"
SRC_URI="http://www.cpan.org/modules/by-module/Data/${A}"
HOMEPAGE="http://www.cpan.org/modules/by-module/Data/${P}.readme"

DEPEND=">=sys-devel/perl-5"

src_compile() {
    perl Makefile.PL
    try make
    #try make test
}

src_install () {
    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 \
	INSTALLMAN1DIR=${D}/usr/share/man/man1 install
    dodoc Changes Copyright GNU-LICENSE MANIFEST README
    docinto html
    dodoc *.html
}



