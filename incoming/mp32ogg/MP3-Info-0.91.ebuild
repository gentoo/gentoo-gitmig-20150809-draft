# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Kalen Petersen <kalenp@cs.washington.edu>
# /home/cvsroot/gentoo-x86/dev-perl/MP3-Info/MP3-Info-0.91.ebuild,v 1.0 2001/03/10 23:09:37 achim Exp

P=MP3-Info-0.91
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Perl module for manipulating and fetching info from MP3 audio files"
SRC_URI="http://www.cpan.org/authors/id/C/CN/CNANDOR/${A}"
HOMEPAGE="http://www.cpan.org/authors/id/C/CN/CNANDOR/${P}.readme"

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









