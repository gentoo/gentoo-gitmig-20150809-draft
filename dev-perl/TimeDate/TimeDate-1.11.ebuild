# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TimeDate/TimeDate-1.11.ebuild,v 1.1 2002/04/22 20:12:54 agenkin Exp $

DESCRIPTION="A Date/Time Parsing Perl Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/Date/${P}.readme"

SRC_URI="http://www.cpan.org/modules/by-module/Date/${P}.tar.gz"

DEPEND=">=sys-devel/perl-5"

src_compile() {
    perl Makefile.PL /usr || die
    make || die
}

src_install () {
    make PREFIX=${D}/usr \
         INSTALLMAN3DIR=${D}/usr/share/man/man3 \
         install || die
    dodoc ChangeLog MANIFEST README
}
