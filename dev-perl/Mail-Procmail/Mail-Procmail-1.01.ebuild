# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Procmail/Mail-Procmail-1.01.ebuild,v 1.5 2002/07/25 04:13:26 seemant Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Mail sorting/delivery module for Perl."
SRC_URI="http://www.cpan.org/modules/by-module/Mail/${A}"
SLOT="0"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

SLOT="0"
DEPEND=">=sys-devel/perl-5
        >=dev-perl/MailTools-1.15
        >=dev-perl/LockFile-Simple-0.2.5"

src_compile() {

    perl Makefile.PL
    try make
    try make test
}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc CHANGES MANIFEST README

}
