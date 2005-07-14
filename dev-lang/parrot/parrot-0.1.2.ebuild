# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/parrot/parrot-0.1.2.ebuild,v 1.4 2005/07/14 21:07:36 agriffis Exp $

inherit base eutils

DESCRIPTION="The virtual machine that perl6 relies on."
HOMEPAGE="http://www.parrotcode.org/"
SRC_URI="mirror://cpan/authors/id/L/LT/LTOETSCH/${S}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE=""

#this ebuild has been tested with the given perl
#if we trust the README then 5.6 should also be ok.
DEPEND=">=dev-lang/perl-5.8.5-r2
		>=dev-libs/icu-2.6"

src_compile()	{
	#This configure defines the DESTDIR for make.
	perl Configure.pl --prefix=${D}|| die "Perl ./Configure.pl failed"
	emake -j1 || die "emake failed"
}

src_install()	{
	#The prefix was set by Configure.pl - see src_compile().
	make install BUILDPREFIX=${D} PREFIX=/usr/lib/${P} || die
	dodir /usr/bin
	dosym /usr/lib/${P}/bin/parrot /usr/bin

	#copy some special files escpecially mod_parrot-0.1
	#maybe this should depend on a USE-Flag i.e. apache

	#install libparrot.a into /usr/lib/
	dolib.a blib/lib/*.a
	dosym /usr/lib/${P}/bin/parrot /usr/lib/${P}/parrot

	insinto /usr/lib/${P}
	doins config_lib.pasm
	dodir /usr/lib/${P}/include
	dodir /usr/lib/${P}/include/parrot
	insinto /usr/lib/${P}/include/parrot/
	doins ${S}/include/parrot/*.h

	dodir /usr/share/doc/${P}
	dodoc README RESPONSIBLE_PARTIES ABI_CHANGES ChangeLog CREDITS DEVELOPING
}
