# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Aaron Blew <moath@oddbox.org>
# /home/cvsroot/gentoo-x86/dev-perl/Net-IRC,v 1.2 2001/02/15 18:17:31 achim Exp

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Perl IRC module"
SRC_URI="http://www.cpan.org/authors/id/F/FI/FIMM/Net-IRC-0.70.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=Net::IRC"

DEPEND=">=sys-devel/perl-5.6.1"

src_compile() {

	try perl Makefile.PL
    	try make

}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN1DIR=${D}/usr/share/man/man1 \
	INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc Changes MANIFEST README TODO
}

