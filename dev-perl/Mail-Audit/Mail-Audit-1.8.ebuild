# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Audit/Mail-Audit-1.8.ebuild,v 1.1 2001/02/16 20:01:14 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Mail sorting/delivery module for Perl."
SRC_URI="http://www.cpan.org/modules/by-module/Mail/${A}"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

DEPEND=">=sys-devel/perl-5
        >=dev-perl/libnet-1.0703
        >=dev-perl/POP3Client-2.7
	>=dev-perl/MailTools-1.15"

src_compile() {

    perl Makefile.PL
    try make
    try make test

}

src_install () {

    try make PREFIX=${D}/usr install
    dodoc Changes MANIFEST README

}
