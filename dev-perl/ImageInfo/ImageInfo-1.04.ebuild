# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ImageInfo/ImageInfo-1.04.ebuild,v 1.2 2001/05/03 16:38:57 achim Exp $
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
    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc ChangeLog MANIFEST README ToDo
}



