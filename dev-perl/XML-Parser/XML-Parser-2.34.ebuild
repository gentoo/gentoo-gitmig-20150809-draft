# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Parser/XML-Parser-2.34.ebuild,v 1.22 2007/01/19 17:39:16 mcummings Exp $

inherit perl-module multilib

DESCRIPTION="A Perl extension interface to James Clark's XML parser, expat"
HOMEPAGE="http://search.cpan.org/~msergeant/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSERGEANT/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ~ppc-macos ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-libs/expat-1.95.1-r1
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:^\$expat_libpath.*:\$expat_libpath = '/usr/$(get_libdir)';:" \
		Makefile.PL || die "sed failed"
}
