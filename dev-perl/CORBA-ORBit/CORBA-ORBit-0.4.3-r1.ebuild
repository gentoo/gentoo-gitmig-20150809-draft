# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CORBA-ORBit/CORBA-ORBit-0.4.3-r1.ebuild,v 1.2 2002/07/11 06:30:21 drobbins Exp $

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
    perl Makefile.PL
    # Fix for missing IDL headers
    cp Makefile Makefile.orig
    sed -e "s:-I/usr/include/orbit-1.0:-I/usr/include/orbit-1.0 -I/usr/include/libIDL-1.0/:" \
	Makefile.orig > Makefile
    try make 
    try make test
}

src_install () {
    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc ChangeLog MANIFEST README
}



