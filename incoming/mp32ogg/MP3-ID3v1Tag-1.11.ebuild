# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Kalen Petersen <kalenp@cs.u.washington.edu>
# /home/cvsroot/gentoo-x86/dev-perl/MP3-ID3v1Tag/MP3-ID3v1Tag-1.11.ebuild,v 1.0 2001/03/10 12:39:37 achim Exp

P=MP3-ID3v1Tag-1.11
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Perl module for reading ID3v1 tags from MP3 files"
SRC_URI="http://www.cpan.org/authors/id/S/SV/SVANZOEST/${A}"
HOMEPAGE="http://www.cpan.org/authors/id/S/SV/SVANZOEST/${P}.readme"

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









