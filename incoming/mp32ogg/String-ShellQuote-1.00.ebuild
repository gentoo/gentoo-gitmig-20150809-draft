# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Kalen Petersen <kalenp@cs.u.washington.edu>
# /home/cvsroot/gentoo-x86/dev-perl/String-ShellQuote/String-ShellQuote-1.00.ebuild,v 1.0 2001/03/10 12:50:37 achim Exp

P=String-ShellQuote-1.00
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The Perl Shell Quoting Module"
SRC_URI="http://www.cpan.org/authors/id/R/RO/ROSCH/${A}"
HOMEPAGE="http://www.cpan.org/authors/id/R/RO/ROSCH/${P}.readme"

DEPEND=">=sys-devel/perl-5"

src_compile() {

    perl Makefile.PL 
    try make 
    make test
}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc Changes MANIFEST README 

}



