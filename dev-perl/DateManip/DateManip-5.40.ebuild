# Copyright 2002 Arcady Genkin <agenkin@thpoon.com>
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateManip/DateManip-5.40.ebuild,v 1.2 2002/07/11 06:30:21 drobbins Exp $

DESCRIPTION="Perl date manipulation routines."
HOMEPAGE="http://www.perl.com/CPAN/authors/id/SBECK/${P}.readme"

SRC_URI="http://www.perl.com/CPAN/authors/id/SBECK/${P}.tar.gz"

DEPEND=">=sys-devel/perl-5"

src_compile() {
    perl Makefile.PL || die
    make || die
}

src_install () {
    make PREFIX=${D}/usr \
         INSTALLMAN3DIR=${D}/usr/share/man/man3 \
         install || die
    dodoc ChangeLog MANIFEST README HISTORY TODO
}
