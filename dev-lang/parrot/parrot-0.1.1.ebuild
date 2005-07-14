# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/parrot/parrot-0.1.1.ebuild,v 1.6 2005/07/14 21:07:36 agriffis Exp $

DESCRIPTION="The virtual machine that perl6 relies on."
HOMEPAGE="http://www.parrotcode.org/"
SRC_URI="mirror://cpan/authors/id/L/LT/LTOETSCH/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

#this ebuild has been tested with the given perl
#if we trust the README then 5.6 should also be ok.
DEPEND=">=dev-lang/perl-5.8.5-r2
	>=dev-libs/icu-2.6"

src_compile() {
	#This configure defines the DESTDIR for make.
	perl Configure.pl --prefix=${D}|| die "Perl ./Configure.pl failed"
	emake -j1 || die "emake failed"
}

src_install() {

	#The prefix was set by Configure.pl - see src_compile().
	make install BUILDPREFIX=${D} PREFIX=/usr/lib/${P} || die
	dodir /usr/bin
	dosym /usr/lib/${P}/bin/parrot /usr/bin

	#TODO: put the doc (pod) and examples in a special dir
	#/docs/ /examples/
	#Note: this is not yet supported by the Makefile

	#TODO:
	#dodoc ...
}
