# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ImageInfo/ImageInfo-1.04.ebuild,v 1.1 2001/04/28 21:25:55 achim Exp $
P=Image-Info-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Image-Info Module"
SRC_URI="http://www.cpan.org/modules/by-module/Image/${A}"
HOMEPAGE="http://www.cpan.org/modules/by-module/Image/${P}.readme"

DEPEND=">=sys-devel/perl-5"


src_compile() {
    perl Makefile.PL
    try make
    try make test
}

src_install () {
    try make PREFIX=${D}/usr install
    dodoc ChangeLog MANIFEST README ToDo
}



