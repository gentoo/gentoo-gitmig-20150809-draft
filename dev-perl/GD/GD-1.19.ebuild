# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD/GD-1.19.ebuild,v 1.2 2001/01/27 14:41:33 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl DBI Module"
SRC_URI="http://www.cpan.org/modules/by-module/GD/${A}"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"

DEPEND=">=sys-devel/perl-5"
RDEPEND="$DEPEND"

src_compile() {
    cd ${S}
    perl Makefile.PL
    try make
    try make test
}

src_install () {
    cd ${S}
    try make PREFIX=${D}/usr install
    dodoc ChangeLog MANIFEST README*
    docinto html
    dodoc GD.html
}



