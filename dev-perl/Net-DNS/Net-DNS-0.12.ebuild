# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DNS/Net-DNS-0.12.ebuild,v 1.1 2002/01/26 08:16:35 blocke Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Perl Net::DNS - Perl DNS Resolver Module"
SRC_URI="http://www.fuhr.org/~mfuhr/perldns/${P}.tar.gz"
HOMEPAGE="http://www.fuhr.org/~mfuhr/perldns/"

DEPEND=">=sys-devel/perl-5.6.1"

src_compile() {

	perl Makefile.PL || die
	make || die
}

src_install () {

	make PREFIX=${D}/usr INSTALLMAN1DIR=${D}/usr/share/man/man1 \
	  INSTALLMAN3DIR=${D}/usr/share/man/man3 install || die

	dodoc Changes MANIFEST README TODO
}
