# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MailTools/MailTools-1.15.ebuild,v 1.4 2002/07/25 04:13:26 seemant Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Basic mail modules for Perl"
SRC_URI="http://www.cpan.org/modules/by-module/Mail/${A}"
SLOT="0"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

SLOT="0"
DEPEND=">=sys-devel/perl-5
        >=dev-perl/libnet-1.0703"

src_compile() {
    perl Makefile.PL
    try make
    try make test
}

src_install () {
    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc ChangeLog MANIFEST README README.demos
}
