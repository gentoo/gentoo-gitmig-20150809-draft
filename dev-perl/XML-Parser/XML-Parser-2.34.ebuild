# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Parser/XML-Parser-2.34.ebuild,v 1.18 2006/07/05 13:33:10 ian Exp $

inherit perl-module multilib

DESCRIPTION="A Perl extension interface to James Clark's XML parser, expat"
HOMEPAGE="http://search.cpan.org/~msergeant/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSERGEANT/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-libs/expat-1.95.1-r1"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:^\$expat_libpath.*:\$expat_libpath = '/usr/$(get_libdir)';:" \
		Makefile.PL || die "sed failed"
}