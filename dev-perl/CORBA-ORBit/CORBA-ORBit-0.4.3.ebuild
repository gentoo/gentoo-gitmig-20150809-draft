# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CORBA-ORBit/CORBA-ORBit-0.4.3.ebuild,v 1.2 2001/01/15 21:33:51 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A Convert Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/CORBA/${A}"
HOMEPAGE="http://www.cpan.org/modules/by-module/CORBA/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=dev-perl/Error-0.13
	>=gnome-base/ORBit-0.5.6"

src_compile() {
    cd ${S}
    perl Makefile.PL
    try make 
    try make test
}

src_install () {
    cd ${S}
    try make PREFIX=${D}/usr install
    dodoc ChangeLog MANIFEST README
}



