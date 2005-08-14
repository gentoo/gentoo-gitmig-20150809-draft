# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Parser/XML-Parser-2.34.ebuild,v 1.15 2005/08/14 21:05:31 kito Exp $

inherit perl-module multilib

DESCRIPTION="A Perl extension interface to James Clark's XML parser, expat"
SRC_URI="mirror://cpan/authors/id/M/MS/MSERGEANT/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~msergeant/${P}/"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 s390 sparc x86"
IUSE=""

DEPEND=">=dev-libs/expat-1.95.1-r1"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:^\$expat_libpath.*:\$expat_libpath = '/usr/$(get_libdir)';:" \
		Makefile.PL || die "sed failed"
}
