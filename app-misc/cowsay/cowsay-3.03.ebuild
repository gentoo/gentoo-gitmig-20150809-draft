# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/cowsay/cowsay-3.03.ebuild,v 1.1 2002/07/21 21:56:37 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Cowsay is a configurable talking cow written in Perl"
SRC_URI="http://www.nog.net/~tony/warez/${P}.tar.gz"
HOMEPAGE="http://www.nog.net/~tony/warez/cowsay.shtml"
DEPEND="sys-devel/perl"
SLOT="0"
KEYWORDS="*"
LICENSE="Artistic"

src_compile() {

	# cowsasy is a perl script so all we have to do is set up some variables

	mv cowsay cowsay.orig
	sed -e 's|%BANGPERL%|\!/usr/bin/perl|g' \
		-e 's|%PREFIX%|/usr|g' \
		-e 's|/share/cows|/share/cowsay|g' \
		-e 's| qw(expand)||g' \
		-e 's| qw(wrap fill $columns)||g' \
			cowsay.orig > cowsay || die

}	

src_install() {

	dobin cowsay
	dosym cowsay /usr/bin/cowthink
	
	doman cowsay.1
	dosym cowsay.1.gz /usr/share/man/man1/cowthink.1.gz
	
	dodoc ChangeLog LICENSE MANIFEST README LICENSE

	# now for the cowfiles
	dodir /usr/share/cowsay
	cp ${S}/cows/* ${D}/usr/share/cowsay || die
	
}
